include "i3/prelude";

# Find leaf nodes that have no parent for which the given filter applies
def tiles(condition):
  select(condition)
  | if .nodes != [] then .nodes[] | tiles(condition) else . end;

# Focus on the i'th child, excluding anything that is tabbed or stacked
def tile($offset):
  workspace
  | window as $w
  | [tiles(.layout | . != "stacked" and . != "tabbed")]
  | (position(.id == $w.id) // 0) as $i
  | length as $n
  | .[$i + $offset | clamp(0; $n)];


def focus_tile($offset):
  tile($offset)
  | "[con_id=\(.id)] focus";

def focus_tile: focus_tile(($ARGS.positional[0] // 0) | numeric);
