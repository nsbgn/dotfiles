# Descend tree structure until finding focused workspace
def workspace:
    .focus[0] as $i
    | .nodes[]
    | select(.id == $i)
    | if .type == "workspace" then . else workspace end;

# Descend tree structure into focused node one level
def descend:
    .focus[0] as $i
    | .nodes[], .floating_nodes[]
    | select(.id == $i);

# All leaf nodes in the given container
def leaves:
    if .nodes != [] then .nodes[] | leaves else . end;
    # Same as recurse/etc?

# Clamp a number to minimum and maximum values
def clamp($min; $max):
    if . >= $min then if . <= $max then . else $max end else $min end;

# Find the container a given offset away from the focused container in a list
def offset($d):
    (map(.focused) | index(true)) as $i | .[($i + $d) | clamp(0; length)] ;


# Commands ###################################################################

def focus($d):
    [workspace | leaves] | offset($d) | "[con_id=\(.id)] focus";
