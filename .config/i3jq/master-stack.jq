# This is a long-running script that implements a master-stack layout. That 
# means that there is one "main" window and any additional window gets stacked 
# to the side. TODO This is just for the case where the master window is to the 
# right.

import "i3jq/ipc" as ipc;
import "i3jq/tree" as tree;

def insert: "insert";
def swap: "swap";

def some(generator):
  first(generator | select(.) | true) // false;

def event(event; change):
  (.event as $e | any(event; $e == .)) and
  (.change as $c | any(change; $c == .));

def mark($mark; $yes):
  some(.marks[] == $mark) as $marked |
  if $yes and ($marked | not) then
    "[con_id=\(.id)] mark --add \($mark)"
  elif ($yes | not) and $marked then
    "unmark \($mark)"
  else
    empty
  end;
def mark($mark): mark($mark; true);

# Organize a workspace into a master-stack layout. This does assume that the 
# workspace was empty from the moment that the script took effect; otherwise 
# some complex reordering would be needed that is a TODO
def apply_layout:
  (.nodes | length) as $n |
  if $n > 1 then
    .nodes[0] |
    if .layout == "none" then
      mark(insert),
      "[con_id=\(.id)] splitv"
    else
      tree::focus |
      mark(insert)
    end, "unmark \(swap)"
  elif $n == 1 then
    .nodes[0] |
    if .layout == "none" then
      mark(swap), mark(insert)
    elif (.nodes | length) == 1 then
      .nodes[0] |
      "[con_id=\(.id)] split none",
      mark(swap), mark(insert)
    else
      # When there is only one top-level node, we want to assume that there is 
      # also just one master window, but that might not be true if we just 
      # closed the previous master window. In that case, we select the second 
      # most recently focused window in this stack and promote it to master
      (tree::focus_child(1) | "[con_id=\(.id)] move right"),
      (tree::focus_child(0) | mark(insert), "unmark \(swap)")
    end
  elif $n == 0 then
    "unmark \(swap)", "unmark \(insert)"
  else
    empty
  end;

def handler:
  ipc::subscribe(["workspace", "window"]) |
  if event("workspace"; "focus") or event("window"; "new", "close") then
    ipc::do(
      ipc::get_tree |
      tree::focus(.type == "workspace") |
      apply_layout
    )
  elif event("window"; "focus") then
    ipc::do(
      ipc::get_tree |
      tree::focus(.type == "workspace") |
      (.nodes[0] // empty) |
      tree::focus |
      mark(insert)
    )
  else
    empty
  end;

# To instantly put new tiling windows where they belong, without a moment of 
# flickering as the script responds to events, we start by putting in place 
# rules to insert new windows after the window with the `insert` mark. To put 
# it *before* that window, also set the `swap` mark.
ipc::do(
  "for_window [tiling] move container to mark \(insert)",
  "for_window [tiling] swap container with mark \(swap)"),
handler
