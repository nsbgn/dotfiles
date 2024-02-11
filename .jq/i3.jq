# Descend tree structure into focused node one level
def descend:
    .focus[0] as $i
    | .nodes[], .floating_nodes[]
    | select(.id == $i);

# Descend tree structure until finding focused workspace
def workspace:
    until(.type == "workspace"; descend);

# All tiled leaf nodes in the given container
def tiles:
    recurse(.nodes[]) | select(.type == "con" and .nodes == []);

# Clamp a number to minimum and maximum values
def clamp($min; $max):
    if . >= $min then if . <= $max then . else $max end else $min end;

# Find the container a given offset away from the focused container in a list
def offset($d):
    (map(.focused) | index(true)) as $i | .[($i + $d) | clamp(0; length)] ;


# Commands ###################################################################

def focus($d):
    [workspace | tiles] | offset($d) | "[con_id=\(.id)] focus";
