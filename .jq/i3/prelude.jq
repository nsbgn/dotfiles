# Prelude

# Utility filters

def assert($condition):
  if $condition then . else error("an assertion failed") end;

# Find the index of the first item satisfying the condition in an array
def position(condition):
  (map(condition) | index(true));

# Is a value among the given values? 2 | among(1, 2, 3) == true
def among(f):
  first(. == f // empty) // false;

# Clamp a number to minimum and maximum values
def clamp($min; $max):
  if . >= $min then if . <= $max then . else $max end else $min end;

# Snap a number to the last value if greater than 0
def snap:
  if . > 0 then -1 else 0 end;

# Convenience function to exectue a command only when a condition passes
def when(condition; filter):
  if condition then filter else "nop" end;

# Sway-specific

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

def focus_indexr:
  focus_index - (.nodes | length);

# Descend tree structure until finding focused workspace
def workspace:
  until(.type == "workspace"; descend);

# Find window that would be focused if this container receives focus
def window:
  until(.nodes == []; descend_any);

# Find scratchpad workspace from root node
def scratchpad:
  .nodes[] | select(.name == "__i3") | .nodes[0];

# All tiled leaf nodes in the given container
def tiles:
  recurse(.nodes[]) | select(.type == "con" and .nodes == []);

# Convenience function to turn a word into a corresponding number
def numeric:
  if . == "next" or . == "second" then 1
  elif . == "first" then 0
  elif . == "last" or . == "prev" or . == "previous" then -1
  else tonumber end;

def is_horizontal:
  .layout | among("splith", "tabbed");

def is_vertical:
  .layout | among("splitv", "stacked");
