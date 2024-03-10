# Prelude

def assert($condition):
  if $condition then . else error("an assertion failed") end;

# Find the index of the first item satisfying the condition in an array
def position(condition):
  (map(condition) | index(true));

# Descend tree structure one level, into the "most" focused node from the given 
# nodes (typically .nodes[] and/or .floating_nodes[])
def descend(nodes):
  first((.focus | .[]) as $i | nodes | select(.id == $i));

# Descend tree structure into focused node one level
def descend_any:
  descend(.nodes[], .floating_nodes[]);

def descend:
  descend(.nodes[]);

# Find out what the position of the focused container is in its node list. This 
# is related to descend/1.
def focus_index:
  .focus[0] as $i
  | .nodes
  | position(.id == $i);

# Descend tree structure until finding focused workspace
def workspace:
  until(.type == "workspace"; descend);

# Find focused window
def window:
  until(.focused; descend_any);

# Find scratchpad workspace from root node
def scratchpad:
  .nodes[] | select(.name == "__i3") | .nodes[0];

# All tiled leaf nodes in the given container
def tiles:
  recurse(.nodes[]) | select(.type == "con" and .nodes == []);

# Clamp a number to minimum and maximum values
def clamp($min; $max):
  if . >= $min then if . <= $max then . else $max end else $min end;

# Snap a number to the last value if greater than 0
def snap:
  if . > 0 then -1 else 0 end;

# Convenience function to exectue a command only when a condition passes
def when(condition; filter):
  if condition then filter else "nop" end;

# Convenience function to turn a word into a corresponding number
def numeric:
  if . == "next" or . == "second" then 1
  elif . == "first" then 0
  elif . == "last" or . == "prev" or . == "previous" then -1
  else tonumber end;


def partition(condition):
  position(condition) as $i
  | {before: .[:$i], current: .[$i], after: .[($i + 1):]};

# Select the given index from an array, shifted by the given offset
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

def alt_cycle_hidden($d):
  null;

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


def among(f):
  first(. == f // empty) // false;

def ordinal_direction:
  if among("leftup", "northwest", "nw") then
    {y: -1, x: -1}
  elif among("rightup", "northeast", "ne") then
    {y: -1, x: 1}
  elif among("leftdown", "southwest", "sw") then
    {y: 1, x: -1}
  elif among("rightdown", "southeast", "se") then
    {y: 1, x: 1}
  else
    error("\(.) is not recognized as an ordinal direction.")
  end;

def is_horizontal:
  .layout | among("splith", "tabbed");

def is_vertical:
  .layout | among("splitv", "stacked");

# Select the leaf container occupying the given corner of the current 
# container.
def corner($dir):
  if .nodes == [] then
    .
  else
    .nodes[
      if (is_vertical and $dir.y < 0) or (is_horizontal and $dir.x < 0) then
        0
      else
        -1
      end] | corner($dir)
  end;

# Try to travel along the given ordinal dimension while staying inside the 
# current container. If it fails we can try in the enclosing container.
def look_inside($dir):
  focus_index as $i
  | (.nodes | length) as $n # existence of $i implies that $n>0
  | is_horizontal as $h
  | is_vertical as $v
  | (if $h then $dir.x elif $v then $dir.y else empty end) as $d
  | if ($d < 0 and $i > 0) or ($d > 0 and $i < $n - 1) then
      .nodes[$i + $d]
      | corner(if $h then {x: -$d, y: $dir.y} else {x: $dir.x, y: -$d} end)
    else
      empty
    end;

def look($dir):
  (descend | look($dir)) // look_inside($dir);

# Shift focus in the given ordinal direction.
# Usually, there should be only two or three windows on the screen, so it makes 
# sense to engineer the selection mechanism such that you can usually shift 
# focus to any one of them within a single keypress. Therefore, instead of the 
# four cardinal directions (that is, i3's usual left/right/up/down), we use the 
# ordinal directions (but only actually travel along the axis of the current 
# split unless you've reached the end of said split or if you're at the edge of 
# the screen and you're travelling away from it). Granted, this is slightly 
# less intuitive in complicated layouts --- but complicated layouts should 
# hardly ever occur, while this allows you to immediately travel to windows in 
# the 'corner', which is an efficient and visually intuitive way to get around 
# in master-stack layouts.
def focus_ordinal($dir):
  ($dir | ordinal_direction) as $dir
  | look($dir)
  | "[con_id=\(.id)] focus";

# Allows you to run commands via jq "$1" --args "$@"
def focus_float: focus_float($ARGS.positional[1] | numeric);
def focus_tile: focus_tile($ARGS.positional[1] | numeric);
def cycle_hidden: cycle_hidden($ARGS.positional[1] | numeric);
def move_to_float: move_to_float($ARGS.positional[1] | numeric);
def move_to_tiled: move_to_tiled($ARGS.positional[1] | numeric);

def focus_ordinal: focus_ordinal($ARGS.positional[1]);
