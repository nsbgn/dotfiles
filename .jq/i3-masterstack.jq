include "i3";

def event_init:
  "for_window [title=\".\"] move container to mark insert";

# TODO descend down singleton nodes
def something:
  if (.nodes | length) == 1 then
    .nodes[0] | something
  else
    .
  end;

def normalize:
  workspace
  | something
  | if (.nodes | length) > 1 then
      .nodes[1]
      | when(.layout == "none"; "[con_id=\(.id)] split toggle")
    else
      "nop"
    end;

def event_workspace_focus($tree):
  $tree
  | workspace
  | [tiles]
  | if . == [] then
      "unmark insert"
    else
      "[con_id=\(.[-1].id)] mark insert"
    end;

def event_window_new($tree):
  "[con_id=\(.container.id)] mark insert; "
  + ($tree | normalize);

def event_window_focus($tree):
  "nop";
