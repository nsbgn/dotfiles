# Prelude

def assert($condition):
  if $condition then . else error("an assertion failed") end;

# Descend tree structure one level, into the "most" focused node from the given 
# nodes (typically .nodes[] and/or .floating_nodes[])
def descend(nodes):
  first((.focus | .[]) as $i | nodes | select(.id == $i));

# Descend tree structure into focused node one level
def descend:
  descend(.nodes[], .floating_nodes[]);

# Descend tree structure until finding focused workspace
def workspace:
  until(.type == "workspace"; descend);

# Find focused window
def window:
  until(.focused; descend);

# Find scratchpad workspace from root node
def scratchpad:
  .nodes[] | select(.name == "__i3") | .nodes[0];

# All tiled leaf nodes in the given container
def tiles:
  recurse(.nodes[]) | select(.type == "con" and .nodes == []);

# Clamp a number to minimum and maximum values
def clamp($min; $max):
  if . >= $min then if . <= $max then . else $max end else $min end;

# Convenience function to exectue a command only when a condition passes
def when(condition; filter):
  if condition then filter else "nop" end;

# Convenience function to turn a word into a corresponding number
def numeric:
  if . == "next" or . == "second" then 1
  elif . == "first" then 0
  elif . == "prev" or . == "previous" then -1
  else tonumber end;

# Find the index of the first item satisfying the condition in an array
def position(condition):
  (map(condition) | index(true));

def partition(condition):
  position(condition) as $i
  | {before: .[:$i], current: .[$i], after: .[($i + 1):]};

# Halfwm #####################################################################

# Add the position of a minimized window according to its marks
def location:
  .marks[]
  | match("_ws([0-9]+)_pos(-?[0-9]+)")
  | { workspace: (.captures[0].string | tonumber),
      idx: (.captures[1].string | tonumber)};

# Find all currently minimized windows associated with the given workspace
def hidden_unsorted($ws):
  [scratchpad
  | .floating_nodes[]
  | . += location
  | select(.workspace == ($ws | .num // .))];

def hidden($ws):
  hidden_unsorted($ws)
  | sort_by(.idx);

# Is the most recently minimized window at the end or at the beginning of the
# hidden windows?
def mru($ws):
  hidden_unsorted($ws)
  | length as $n
  | first(.[] | select(.idx == 0 or .idx == $n));

# Get current workspace, current window and hidden windows
def state:
  workspace as $workspace
  | hidden($workspace) as $hidden
  | $workspace | window as $window
  | {$workspace, $hidden, $window};

# Commands ###################################################################

def unmark_position:
  if has("idx")
  then "[con_id=\(.id)] unmark _ws\(.workspace)_pos\(.idx)"
  else empty end;

def mark_position($ws; $n):
  "[con_id=\(.id)] mark --add _ws\($ws)_pos\($n)";

# Hide the input container
def hide($after; $ws; $hidden):
  assert(.type == "con"
    and ($after | type) == "boolean"
    and ($ws | type) == "number"
    and ($hidden | type) == "list")
  | (if $after
      then ($hidden[-1].idx // 0) + 1
      else ($hidden[0].idx // 0) - 1 end) as $i
  | "[con_id=\(.id)] mark --add _ws\($ws)_pos\($i); [con_id=\(.id)] move to scratchpad";

# Move the input container to the given container
def move_to($anchor):
  "_tmp\($anchor.id)" as $m
  | "[con_id=\($anchor.id)] mark \($m)"
  + "[con_id=\(.id)] move to mark \($m)"
  + "[con_id=\($anchor.id)] unmark \($m)";

# Swap the input container with the given one
def swap($anchor):
  "[con_id=\(.id)] swap container with con_id \($anchor.id)";

# Hide all windows except the focused window. The windows occurring before the
# focused window are hidden 'before' (ie at the end), the windows occurring
# after are hidden 'after' (ie at the beginning).
def hide_other:
  state as {$workspace, $window, $hidden}
  | [$workspace | tiles]
  | partition(.focused) as {$before, $after}
  | $after + $hidden + $before
  | [ to_entries[] | .key as $i | .value
    | mark_position($workspace.num; $i), "[con_id=\(.id)] move to scratchpad"]
  | join("; ");

# Put the most recently hidden window of this workspace back in the tiling
# tree. Put it back where it came from:
def unhide:
  state as {$workspace, $window, $hidden}
  | mru($workspace) as $mru
  | [ ($mru | move_to($window))
    , if $mru.idx > 0
      then empty
      else ($mru | swap($window))
      end
    ]
  | join("; ");


# Push the currently focused floating container into the tiling tree at the
# given index, such that the tile currently at that position is displaced. That
# is, if it is sent to $i=0 and there is only one tile, that tile other tile
# moves to $i=1 and if it is sent to $i=1, the incumbent tile stays at $i=0. If
# there are already two tiles, however, it is hidden before if $i=0 or after if
# $i=1
def move_to_tile($i):
  state as {$workspace, window: $w, $hidden}
  | assert($i == 0 or $i == 1)
  | [$workspace | tiles] as $tiles
  | $tiles[0] as $t
  | ($tiles | length) as $n
  | (if $w.type == "floating_con" then
      (if $n == 0 then
        "[con_id=\($w.id)] floating disable"
      elif $n == 1 then
        $w | move_to($t) + "; " + when($i != 0; swap($t))
      else
        $t | swap($w) + "; " + hide($i != 0; $workspace.num; $hidden)
      end)
    else
      when($n > 1; $tiles[$i] | swap($w))
    end);

def toggle_tiling_mode:
  ([workspace | tiles] | length) as $n
  | if $n > 1
    then hide_other
    else unhide end;

def cycle_hidden($d):
  state as {$workspace, $window, $hidden}
  | (if $d > 0 then {i: ($d - 1), j: $d}
    elif $d < 0 then {i: $d, j: ($hidden | length - $d)}
    else empty end) as {$i, $j}
  | ($hidden[$i] // empty) as $goal
  | [ ($goal | swap($window))
    , ($goal | unmark_position)
    , (foreach (($hidden[$j:] | .[]), $window, ($hidden[:$i] | .[])) as $con
      (0; . + 1; $con + {n: .})
      | mark_position($workspace.num; .n))
    ] | join("; ");

# Shift focus on containers, leafing through them in sequence
def shift_focus($offset; aim; containers):
  workspace
  | aim as $aim
  | containers
  | .[position(.id == $aim.id) + (if $aim.focused then $offset else 0 end)
    | clamp(0; length)]
  | "[con_id=\(.id)] focus";

def focus_tile($offset):
  shift_focus($offset;
    until(.nodes == []; descend(.nodes[]));
    [tiles]);

def focus_float($offset):
  shift_focus($offset;
    descend(.floating_nodes[]);
    .floating_nodes);

# Allows you to run commands via jq "$1" --args "$@"
def focus_float: focus_float($ARGS.positional[1] | numeric);
def focus_tile: focus_tile($ARGS.positional[1] | numeric);
def cycle_hidden: cycle_hidden($ARGS.positional[1] | numeric);
