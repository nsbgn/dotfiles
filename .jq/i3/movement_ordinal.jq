include "i3/prelude";

def ordinal_direction:
  if among("leftup", "northwest", "nw") then
    {y: -1, x: -1}
  elif among("rightup", "northeast", "ne") then
    {y: -1, x: 1}
  elif among("leftdown", "southwest", "sw") then
    {y: 1, x: -1}
  elif among("rightdown", "southeast", "se") then
    {y: 1, x: 1}
  else
    error("\(.) is not recognized as an ordinal direction.")
  end;

# Select the leaf container occupying the given corner of the current 
# container.
def corner($dir):
  if .nodes == [] then
    .
  else
    .nodes[
      if (is_vertical and $dir.y < 0) or (is_horizontal and $dir.x < 0) then
        0
      else
        -1
      end] | corner($dir)
  end;

# Treat the focused child as a black box and look from it into the given 
# direction, while staying inside the current container. If this fails, we can 
# treat this container as a black box and try again in the enclosing container.
def look_blackbox($dir; $parent):
  focus_index as $i
  | (.nodes | length) as $n # existence of $i implies that $n>0
  | is_horizontal as $h
  | is_vertical as $v
  | (if $h then $dir.x elif $v then $dir.y else empty end) as $d
  | if ($d < 0 and $i > 0) or ($d > 0 and $i < $n - 1) then

      # If you're at the edge of your enclosing container and looking slightly 
      # away from that edge, you should always see beyond your container even 
      # if you would normally first see a node in the same container. This is 
      # because, if you wanted to travel in the direction of the current 
      # container, you could also 'hug' the edge --- and we want to get where 
      # we're going in as few keystrokes as possible.
      # if try ($parent
      #   | (focus_index == 0) as $fst
      #   | (focus_indexr == -1) as $lst
      #   | (is_horizontal and (($dir.x < 0 and $lst) or ($dir.x > 0 and $fst)))
      #     or (is_vertical and (($dir.y < 0 and $lst) or ($dir.y > 0 and $fst)))
      #   ) catch false
      # then
      #   empty
      # else
        .nodes[$i + $d]
        | corner(if $h then {x: -$d, y: $dir.y} else {x: $dir.x, y: -$d} end)
      # end
    else
      empty
    end;

def look($dir; $parent):
  (. as $parent | descend | look($dir; $parent))
  // look_blackbox($dir; $parent);

# Shift focus in the given ordinal direction.
# Usually, there should be only two or three windows on the screen, so it makes 
# sense to engineer the selection mechanism such that you can usually shift 
# focus to any one of them within a single keypress. Therefore, instead of the 
# four cardinal directions (that is, i3's usual left/right/up/down), we use the 
# ordinal directions (but only actually travel along the axis of the current 
# split unless you've reached the end of said split or if you're at the edge of 
# the screen and you're travelling away from it). Granted, this is slightly 
# less intuitive in complicated layouts --- but complicated layouts should 
# hardly ever occur, while this allows you to immediately travel to windows in 
# the 'corner', which is an efficient and visually intuitive way to get around 
# in master-stack layouts.
def focus_ordinal($dir):
  ($dir | ordinal_direction) as $dir
  | workspace
  | look($dir; null)
  | "[con_id=\(.id)] focus";

def focus_ordinal: focus_ordinal($ARGS.positional[1]);
