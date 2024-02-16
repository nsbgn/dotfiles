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

def renumber($ws; $n):
    [ if has("idx") then "[con_id=\(.id)] unmark _ws\(.workspace)_pos\(.idx)"
    else empty end,
    if $n then "[con_id=\(.id)] mark --add _ws\($ws)_pos\($n)"
    else empty end] | join("; ");

def renumber_multi($ws):
    foreach .[] as $con (0; . + 1; {i: ., con: $con})
    | .i as $i | .con | renumber($ws; $i);


def cycle($d): # command
    workspace as $ws
    | window as $cur
    | hidden($ws) as $hidden
    | ($d | if . > 0 then . - 1 else . end) as $goal_i
    | ($hidden[$goal_i]) as $goal
    | [
        "[con_id=\($cur.id)] swap container with con_id \($goal.id)",
        ($goal | renumber($ws.num; null)),
        ($hidden[:$goal_i] + [$cur] + $hidden[($goal_i + 1):] | 
        renumber_multi($ws.num))
        # ($cur | renumber($ws.num; $hidden[if $d > 0 then -1 else 0 end])),
    ] | join("; ");



# def cycle($d): # command
#     workspace as $ws
#     | window as $cur
#     | hidden($ws) as $hidden
#     | ($d | if . > 0 then . - 1 else . end) as $goal_i
#     | ($hidden[$goal_i]) as $goal
#     | [
#         "[con_id=\($current.id)] swap container with con_id \($goal.id)",
#         ($goal | renumber($ws.num; null)), # Drop target mark
#         ($cur | renumber($ws.num; $hidden[if $d > 0 then -1 else 0 end].idx)),
#         # ($cur | renumber($ws.num; $hidden[if $d > 0 then -1 else 0 end])),
#     ] | join("; ");

# Recalc current mark to last+1 or first+1
# Recalc all $hidden[target_i+1; -1] or $hidden[0; $target_i]

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
