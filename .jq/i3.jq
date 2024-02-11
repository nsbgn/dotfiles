# Descend tree structure until finding focused workspace
def workspace:
    .focus[0] as $i
    | .nodes[]
    | select(.id == $i)
    | if .type == "workspace" then . else workspace end;

# All leaf nodes in the given container
def leaves:
    if .nodes != [] then .nodes[] | leaves else . end;
    # Same as recurse/etc?

# Clamp a number to minimum and maximum values
def clamp($min; $max):
    if . < $min then $min else if . > $max then $max else . end end;

# Find the container a given offset away from the focused container in a list
def offset($d):
    (map(.focused) | index(true)) as $i | .[($i + $d) | clamp(0; length)] ;


# Commands ###################################################################

def focus($d):
    [workspace | leaves] | offset($d) | "[con_id=\(.id)] focus";
