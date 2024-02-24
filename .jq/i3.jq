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


# Halfwm #####################################################################

# Add the position of a minimized window according to its marks
def location:
    .marks[]
    | match("_ws([0-9]+)_pos(-?[0-9]+)")
    | { workspace: (.captures[0].string | tonumber),
        idx: (.captures[1].string | tonumber)};

# Find all currently minimized windows associated with the given workspace
def hidden($ws):
    [scratchpad
    | .floating_nodes[]
    | . += location
    | select(.workspace == ($ws | .num // .))]
    | sort_by(.idx);

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
def cycle_window($d): # command
    [workspace | tiles]
    | .[position(.focused) + $d | clamp(0; length)]
    | "[con_id=\(.id)] focus";
