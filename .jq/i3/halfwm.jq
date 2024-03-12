include "i3/prelude";

def partition(condition):
  position(condition) as $i
  | {before: .[:$i], current: .[$i], after: .[($i + 1):]};

# Select the given index from the input array, shifted by the given offset
def shift($target; $offset):
  if $target then
    length as $n | .[$target + $offset | clamp(0; $n - 1)]
  else
    .[$offset | snap] end;

# Halfwm #####################################################################

def MAX_TILES: 2;

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
    and ($hidden | type) == "array")
  | (if $after
      then ($hidden[-1].idx // 0) + 1
      else ($hidden[0].idx // 0) - 1 end) as $i
  | "[con_id=\(.id)] mark --add _ws\($ws)_pos\($i); [con_id=\(.id)] move to scratchpad";

def hide_before($ws; $hidden):
  hide(false; $ws; $hidden);

def hide_after($ws; $hidden):
  hide(true; $ws; $hidden);

# Swap the input container with the given one
def swap($anchor):
  "[con_id=\(.id)] swap container with con_id \($anchor.id)";

# Move the input container to the given container
def move_after($anchor):
  "_tmp\($anchor.id)" as $m
  | (if .type == "floating_con" then
      "[con_id=\(.id)] floating disable; "
    else
      ""
    end)
  + "[con_id=\($anchor.id)] mark \($m); "
  + "[con_id=\(.id)] move to mark \($m); "
  + "[con_id=\($anchor.id)] unmark \($m)";

def move_before($anchor):
  move_after($anchor) + "; " + swap($anchor);

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
  | [ ($mru | move_after($window))
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
def move_to_tiled($d): # $d in -1, 1
  assert($d == 1 or $d == -1) |
  . as $root
  | state as {$workspace, window: $w, $hidden}
  | [$workspace | tiles] as $tiles
  | ($tiles | position(.focused)) as $i
  | $w
  | if $i then # already tiled
      swap($tiles | shift($i; $d))
    else # still floating
      ($tiles | length) as $n
      | $tiles[$d | snap] as $t
      | if $n == 0 then
          "[con_id=\(.id)] floating disable"
        elif $n < MAX_TILES then
          if $d == -1 then
            move_before($t)
          else
            move_after($t)
          end
        else
          $t
          | swap($w) + "; "
          + (if $d == -1 then
              hide_before($workspace.num; $hidden)
            else
              hide_after($workspace.num; $hidden)
            end)
        end
    end;

# Push the currently focused container into the floating layer, or if it's 
# already floating, swap with the (visually) next or previous container
# TODO
def move_to_float($i):
  window
  | when(.type != "floating_con"; "[con_id=\(.id)] floating enable");

def toggle_tiling_mode:
  ([workspace | tiles] | length) as $n
  | if $n < MAX_TILES then
      unhide
    else
      hide_other
    end;

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

def focus_tile($offset):
  workspace
  | [tiles]
  | shift(position(.focused); $offset) // empty
  | "[con_id=\(.id)] focus";

def focus_float($offset):
  workspace
  | .floating_nodes
  | shift(position(.focused); $offset) // empty
  | "[con_id=\(.id)] focus";

# Allows you to run commands via jq "$1" --args "$@"
def focus_float: focus_float($ARGS.positional[1] | numeric);
def focus_tile: focus_tile($ARGS.positional[1] | numeric);
def cycle_hidden: cycle_hidden($ARGS.positional[1] | numeric);
def move_to_float: move_to_float($ARGS.positional[1] | numeric);
def move_to_tiled: move_to_tiled($ARGS.positional[1] | numeric);
