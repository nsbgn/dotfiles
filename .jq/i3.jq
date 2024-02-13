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
        position: (.captures[1].string | tonumber)};

# Find all currently minimized windows associated with the given
def minimized($ws):
    [scratchpad
    | .floating_nodes[]
    | . += location
    | select(.workspace == ($ws | .num // .))]
    | sort_by(.position)
    | {before: [.[] | select(.position < 0)],
        after: [.[] | select(.position >= 0)]};

def mark($ws; $pos):
    "mark --add _ws\($ws)_pos\($pos)";

# Commands ###################################################################

# Send current window to scratchpad but remember
def minimize:
    workspace as $ws
    | minimized($ws) as {$before, $after}
    | ($ws | window) as $w
    | ("[con_id=\($w.id)] \(mark($ws.num; ($after[-1].position // 0) + 1)); "
        + "[con_id=\($w.id)] move to scratchpad");

# Treat the current tiles as windows to leaf through in sequence
def step($d):
    [workspace | tiles] | offset($d) | "[con_id=\(.id)] focus";
