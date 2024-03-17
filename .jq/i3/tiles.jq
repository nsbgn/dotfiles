module {
  name: "tiles",
  description: "Enumeration of tiles."
};

include "i3/prelude";

# Get all leaf windows in splits plus tabbed/stacking containers (but not the 
# windows within them)
def externals:
  until(is_leaf or is_pile; .nodes[]);

# Get all leaf windows in the same tabbed/stacking container as the one that is 
# in focus within the current container
def internals:
  (tab // window) | tiles;

# Get all leaf windows in all the tabbed/stacked containers, except those that 
# would receive focus wrt their respective tabbed/stacked containers
def unfocused:
  if is_pile then
    .focus[0] as $focused
    | .nodes[]
    | select(.id != $focused)
    | tiles
  else
    .nodes[]
    | unfocused
  end;

# Select the child that is the given offset away from the one that has focus
def tile(generator; $offset; $wrap):
  workspace
  | window as $w
  | [generator | window]
  | at(indexl(.id == $w.id) + $offset; $wrap) // empty;


def focus_external_tile($offset; $wrap):
  tile(externals; $offset; $wrap)
  | "[con_id=\(.id)] focus";

def focus_internal_tile($offset; $wrap):
  tile(internals; $offset; $wrap)
  | "[con_id=\(.id)] focus";

def focus_external: focus_external_tile(($ARGS.positional[0] // 0) | numeric; false);
def focus_internal: focus_internal_tile(($ARGS.positional[0] // 0) | numeric; false);


# Cycle focus through the first stacked/tabbed container on the current 
# workspace, but don't shift focus to it unless you're actually in said 
# container
def cycle($offset):
  workspace
  | window.id as $focus_id
  | find(is_pile)
  | .focus[0] as $focus_id_in_pile
  | .nodes
  | at(indexl(.id == $focus_id_in_pile) + $offset) // empty
  | "[con_id=\(.id)] focus"
  | if $focus_id != $focus_id_in_pile then
      . + "; [con_id=\($focus_id)] focus"
    else . end;

def cycle_prev: cycle(-1);
def cycle_next: cycle(1);

# Same as cycle, but move the focused window along with it
def cycle_hold($offset):
  workspace
  | window.id as $focus_id
  | find(is_pile)
  | .focus[0] as $focus_id_in_pile
  | .nodes as $nodes
  | $nodes
  | indexl(.id == $focus_id_in_pile) as $i
  | at($i + $offset)
  | swap($nodes[$i]);
def cycle_hold_prev: cycle_hold(-1);
def cycle_hold_next: cycle_hold(1);

# the main window is simply the last leaf window that is not part of a 
# stacked/tabbed container. Swap the focused window of the stacked/tabbed 
# container
def swap_main:
  workspace
  | last(externals | select(is_pile | not)) as $main
  | find(is_pile) | window | swap($main);
