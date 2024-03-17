module {
  name: "tiles",
  description: "Enumeration of tiles."
};

include "i3/prelude";

# Get all leaf windows in splits plus tabbed/stacking containers (but not the 
# windows within them)
def externals:
  if is_leaf or is_pile then
    .
  else
    .nodes[] | externals
  end;

# Get all leaf windows in the same tabbed/stacking container as the one that is 
# in focus within the current container
def internals:
  (tab // window) | tiles;

# the main window is simply the first leaf window that is not part of a 
# stacked/tabbed container
def main:
  first(externals | select(is_pile | not));

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
def tile(generator; $offset):
  workspace
  | window as $w
  | [generator | window]
  | at(indexl(.id == $w.id) + $offset) // empty;


def focus_external_tile($offset):
  tile(externals; $offset)
  | "[con_id=\(.id)] focus";

def focus_internal_tile($offset):
  tile(internals; $offset)
  | "[con_id=\(.id)] focus";

def focus_external: focus_external_tile(($ARGS.positional[0] // 0) | numeric);
def focus_internal: focus_internal_tile(($ARGS.positional[0] // 0) | numeric);

def cycle_next:
  workspace
  | main as $main
  | [find(is_pile) | internals] as $pile
  | $pile[0]
  | move_after($pile[-1]) + "; " + swap($main);

def cycle_prev:
  workspace
  | main as $main
  | [find(is_pile) | internals] as $pile
  | $pile[-1]
  | move_before($pile[0]) + "; " + swap($main);
