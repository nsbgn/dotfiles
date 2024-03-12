include "i3/prelude";

def event_init:
  "for_window [title=\".\"] move container to mark insert";

def normalize:
  workspace
  | until(.nodes | length != 1; .nodes[0])
  | (if .nodes | length > 2 then
      [.nodes[2:]
        | .[]
        | tiles
        | "[con_id=\(.id)] move container to mark insert"]
      | join("; ")
    else
      "nop"
    end) as $overflow
  | (if .nodes | length > 1 then
      .nodes[1]
      | when(.layout == "none"; "[con_id=\(.id)] split toggle")
    else
      "nop"
    end) + "; " + $overflow;

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
