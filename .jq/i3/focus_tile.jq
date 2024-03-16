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
  tile(externals; $offset)
  | "[con_id=\(.id)] focus";

def focus_tile: focus_external_tile(($ARGS.positional[0] // 0) | numeric);
