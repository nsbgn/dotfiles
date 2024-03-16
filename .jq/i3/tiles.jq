module {
  name: "tiles",
  description: "Enumeration of tiles."
};

include "i3/prelude";

# Get all leaf windows in splits plus tabbed/stacking containers (but not the 
# windows within them)
def externals:
  if .layout | among("none", "stacked", "tabbed") then
    .
  else
    .nodes[] | externals
  end;

# Get all leaf windows in the same tabbed/stacking container as the focused one
def internals:
  until(.layout | among("none", "stacked", "tabbed"); descend)
  | tiles;


# Get all leaf windows in all the tabbed/stacked containers, except those that 
# would receive focus wrt their respective tabbed/stacked containers
def unfocused:
  if .layout | among("stacked", "tabbed") then
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
