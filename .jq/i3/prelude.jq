module {
  name: "i3",
  description: "Filters that are generally useful for i3/Sway."
};


# Utility filters #######################################################

def assert($condition):
  if $condition then . else error("an assertion failed") end;

# Find the index of the first item satisfying the condition in an array
def indexl(condition):
  map(condition) | index(true);

# Find the negative index of the last item satisfying the condition
def indexr(condition): # TODO
  length - indexl(condition);

# Is a value among the given values? ie `2 | among(1, 2, 3) == true`
def among(f):
  first(. == f // empty) // false;

# Clamp a number to minimum and maximum values
def clamp($min; $max):
  if . >= $min then if . <= $max then . else $max end else $min end;

# Clip a number to minimum and maximum values; empty if outside the values
def clip($min; $max):
  if . >= $min and . <= $max then . else empty end;

# Transform array indices
def wrap($i): $i % length;
def clamp($i): length as $n | $i | clamp(0; $n - 1);
def clip($i): length as $n | $i | clip(0; $n - 1);

# Predicates on containers ###################################################

def is_marked($mark):
  .marks as $marks | $mark | among($marks[]);

def is_horizontal:
  .layout | among("splith", "tabbed");

def is_vertical:
  .layout | among("splitv", "stacked");

def is_pile:
  .layout | among("tabbed", "stacked");

def is_leaf:
  .nodes == [] and .layout == "none";

def is_tile:
  .type == "con" and .nodes == [];


# Finding general containers #################################################

# Descend tree structure one level, into the nth focused node from the given 
# nodes (typically .nodes[] and/or .floating_nodes[])
def descend(generator; $n):
  nth($n; (.focus | .[]) as $i | generator | select(.id == $i)) // empty;

def descend(generator):
  descend(generator; 0);

# Same as descend/1, but descends into a neighbour of the most focused node
# def descend(generator; $offset; $wrap):
#   first(
#     (.focus | .[]) as $id
#     | [generator]
#     | (indexl(.id == $id) + $offset) as $i
#     | .[if $wrap then wrap($i) else clip($i) end]
#   );

def descend_n(generator; $n):
  nth($n; .focus[] as $id | generator | select(.id == $id));

def descend_n($n):
  .focus[$n] as $id
  | .nodes[], .floating_nodes[]
  | select(.id == $id);

# Descend one level into a neighbour of the nth focused tiling node
def descend_neighbour($offset; $wrap; $n):
  nth($n; .focus[] as $id | .nodes | indexl(.id == $id) // empty) as $i
  | ($i + $offset) as $j
  | .nodes
  | .[if $wrap then wrap($j) else clip($j) end];

# Descend one level into a neighbour of the most focused tiling node
def descend_neighbour($offset; $wrap):
  descend_neighbour($offset; $wrap; 0);

# Descend tree structure into focused node one level
def descend_any:
  descend(.nodes[], .floating_nodes[]);

def descend:
  descend(.nodes[]);

# Find a unique node
def find(condition):
  first(recurse(.nodes[], .floating_nodes[]) | select(condition)) // null;

# Find all nodes that satisfy a condition
def find_all(condition):
  recurse(.nodes[], .floating_nodes[]) | select(condition);


# Finding specific containers ################################################

# Find scratchpad workspace from root node
def scratchpad:
  .nodes[] | select(.name == "__i3") | .nodes[0];

# Descend tree structure until finding focused workspace
def workspace:
  until(.type == "workspace"; descend);

# Follow focus until arriving at a tabbed/stacked container
def tab:
  until(is_pile; descend);

# Find window that would be focused if this container receives focus
def window:
  until(.nodes == []; descend_any);

# All tiled leaf nodes in the given container
def tiles:
  recurse(.nodes[]) | select(is_tile);


# Simple commands ############################################################

# Swap the input container with the given one
def swap($anchor):
  "[con_id=\(.id)] swap container with con_id \($anchor.id)";

def focus:
  window | "[con_id=\(.id)] focus";

def mark(marks):
  ["[con_id=\(.id)] mark --add \(marks)"] | join("; ");

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
