include "i3/prelude";


def tiles(exclusion):
  if any(.marks | among($exclude_marks);

# Focus on the i'th child, excluding anything marked "stack"
def focus_tile($i; $exclude_marks):
  workspace
  | recurse(.nodes[]) | select(.type == "con" and .nodes == []);
  | .nodes
  | length as $n
  | .[$i | clamp(-$n; $n)];

def focus_tile: focus_tile(($ARGS.positional[0] // 0) | numeric);
