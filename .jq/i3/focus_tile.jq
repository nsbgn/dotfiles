include "i3/prelude";

# Focus on the i'th child
def focus_tile($i):
  workspace
  | .nodes
  | length as $n
  | .[$i | clamp(-$n; $n)];

def focus_tile: focus_tile(($ARGS.positional[0] // 0) | numeric);
