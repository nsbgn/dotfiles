# Prelude

# Descend tree structure into focused node one level
def descend:
    .focus[0] as $i
    | .nodes[], .floating_nodes[]
    | select(.id == $i);

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

def unnumber:
    if has("idx")
    then "[con_id=\(.id)] unmark _ws\(.workspace)_pos\(.idx)"
    else empty end;

def renumber($ws; $n):
    "[con_id=\(.id)] mark --add _ws\($ws)_pos\($n)";

# Send current window to scratchpad but remember
def hide: # command
    state as {$workspace, $window, $hidden}
    | $window | renumber($workspace.num; ($hidden[-1].idx // 0) + 1)
    + "; [con_id=\(.id)] move to scratchpad";

# Hide all windows except the focused window. The windows occurring before the 
# focused window are hidden 'before' (ie at the end), the windows occurring 
# after are hidden 'after' (ie at the beginning).
def hide_other:
    state as {$workspace, $window, $hidden}
    | [$workspace | tiles]
    | partition(.focused) as {$before, $after}
    | $after + $hidden + $before
    | [ to_entries[] | .key as $i | .value
        | renumber($workspace.num; $i), "[con_id=\(.id)] move to scratchpad"]
    | join("; ");

# Put the most recently hidden window of this workspace back in the tiling 
# tree. Put it back where it came from: 
def unhide:
    state as {$workspace, $window, $hidden}
    | mru($workspace) as $mru
    | [ "[con_id=\($window.id)] mark _tmp",
        "[con_id=\($mru.id)] move to mark _tmp",
        "[con_id=\($window.id)] unmark _tmp",
        if $mru.idx > 0 then empty else
        "[con_id=\($mru.id)] swap container with con_id \($window.id)" end]
    | join("; ");


# Push the currently focused floating container into the tiling tree after the 
# given index
def push($i):
    state as {$workspace, $window, $hidden}
    | if ($window.type != "floating_con") then error("not floating") else . end
    | [$workspace | tiles] as $tiles
    | (tiles | length) as $n
    | if $n == 0 then
        [ "[con_id=\($window.id)] floating disable" ]
      elif $n == 1 then
        [ "[con_id=\($tiles[0].id)] mark _tmp"
        , "[con_id=\($window.id)] move to mark _tmp"
        , "[con_id=\($tiles[0].id)] unmark _tmp"
        , if $i < 0 then
            "[con_id=\($window.id)] swap container with con_id \($tiles[0].id)"
          else empty end
        ] else [
        ] end
    | join("; ")
;

def toggle_tiling_mode:
    ([workspace | tiles] | length) as $n
    | if $n > 1 then hide_other else unhide end;

def cycle_hidden($d): # command
    state as {$workspace, $window, $hidden}
    | (if $d > 0 then {i: ($d - 1), j: $d}
        elif $d < 0 then {i: $d, j: ($hidden | length - $d)}
        else empty end) as {$i, $j}
    | ($hidden[$i] // empty) as $goal
    | [ "[con_id=\($window.id)] swap container with con_id \($goal.id)"
      , ($goal | unnumber)
      , (foreach (($hidden[$j:] | .[]), $window, ($hidden[:$i] | .[])) as $con
        (0; . + 1; $con + {n: .}) | renumber($workspace.num; .n))
      ] | join("; ");

# Treat the current tiles as windows to leaf through in sequence
def cycle_window($offset): # command
    [workspace | tiles]
    | .[position(.focused) + $offset | clamp(0; length)]
    | "[con_id=\(.id)] focus";
