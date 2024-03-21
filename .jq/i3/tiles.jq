module {
  name: "tiles",
  description: "Enumeration of tiles."
};

include "i3/prelude";

# Get all leaf windows in splits plus tabbed/stacking containers (but not the 
# windows within them)
def outer:
  until(is_leaf or is_pile; .nodes[]);

# Get all leaf windows in the same tabbed/stacking container as the one that is 
# in focus within the current container
def inner:
  (tab // window) | tiles;

# Select the child that is the given offset away from the one that has focus
def tile(generator; $offset; $wrap):
  workspace
  | window as $w
  | [generator | window]
  | (indexl(.id == $w.id) + $offset) as $i
  | if $wrap then .[wrap($i)] else .[clip($i)] end;

def focus_outer_tile($offset):
  tile(outer; $offset; false) | focus;

def swap_outer_tile($offset):
  window as $w | tile(outer; $offset; false) | swap($w);

def focus_inner_tile($offset):
  tile(inner; $offset; true) | focus;

def swap_inner_tile($offset):
  window as $w | tile(outer; $offset; true) | swap($w);

def focus_outer_tile: focus_outer_tile(($ARGS.positional[0] // 0) | tonumber);
def focus_inner_tile: focus_inner_tile(($ARGS.positional[0] // 0) | tonumber);

def swap_outer_tile: swap_outer_tile(($ARGS.positional[0] // 0) | tonumber);
def swap_inner_tile: swap_inner_tile(($ARGS.positional[0] // 0) | tonumber);

# Same as focus, but return
def focus_inactive(extra):
  window.id as $focus
  | extra + "; [con_id=\($focus)]";

# Cycle focus through the first stacked/tabbed container on the current 
# workspace
def cycle_inner_focus($offset):
  workspace
  | find(is_pile)
  | .focus[0] as $focus_id_in_pile
  | .nodes
  | .[clamp(indexl(.id == $focus_id_in_pile) + $offset)]
  | focus;

def cycle_inner_focus_prev: cycle_inner_focus(-1);
def cycle_inner_focus_next: cycle_inner_focus(1);

# Same as cycle, but move the focused window along with it
def cycle_inner_swap($offset):
  workspace
  | find(is_pile)
  | .focus[0] as $focus_id_in_pile
  | .nodes
  | .[clamp(indexl(.id == $focus_id_in_pile) + $offset)]
  | "[con_id=\($focus_id_in_pile)] swap container with con_id \(.id)";
def cycle_inner_swap_prev: cycle_inner_swap(-1);
def cycle_inner_swap_next: cycle_inner_swap(1);

# the main window is simply the last leaf window that is not part of a 
# stacked/tabbed container. Swap the focused window of the stacked/tabbed 
# container
def swap_main:
  workspace
  | last(outer | select(is_pile | not)) as $main
  | find(is_pile) | window | swap($main);
