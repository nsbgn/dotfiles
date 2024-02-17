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

# Find the container a given offset away from the focused container in a list
def offset($d):
    (map(.focused) | index(true)) as $i | .[($i + $d) | clamp(0; length)] ;


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

# Commands ###################################################################

def unnumber:
    if has("idx") then "[con_id=\(.id)] unmark _ws\(.workspace)_pos\(.idx)"
    else empty end;

def renumber($ws; $n):
    [ unnumber, "[con_id=\(.id)] mark --add _ws\($ws)_pos\($n)"] | join("; ");

def renumber_multi($ws):
    [foreach .[] as $con (0; . + 1; {i: ., con: $con})
    | .i as $i | .con | renumber($ws; $i)] | join("; ");

def cycle_hidden($d): # command
    workspace as $ws
    | hidden($ws) as $hidden
    | (if $d > 0 then {i: ($d - 1), j: $d}
        elif $d < 0 then {i: $d, j: ($hidden | length - $d)}
        else empty end) as {$i, $j}
    | window as $cur
    | ($hidden[$i] // empty) as $goal
    | "[con_id=\($cur.id)] swap container with con_id \($goal.id); "
    + (($goal | unnumber + "; ") // "")
    + ($hidden[$j:] + [$cur] + $hidden[:$i] | renumber_multi($ws.num));

# Send current window to scratchpad but remember
def minimize: # command
    workspace as $ws
    | hidden($ws) as $after
    | $ws | window
    | (renumber($ws.num; ($after[-1].idx // 0) + 1)
    + "; [con_id=\(.id)] move to scratchpad");

# Treat the current tiles as windows to leaf through in sequence
def step($d): # command
    [workspace | tiles] | offset($d) | "[con_id=\(.id)] focus";
