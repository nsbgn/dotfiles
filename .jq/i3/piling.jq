include "i3/prelude";

def singleton:
  until(.nodes | length != 1; .nodes[0]);


def pile:
  find(is_marked("pile"));


# Ensure that there is a top level container
def ensure_top_level:
  assert(.type == "workspace")
  | if (.nodes | length) > 1 and .nodes[0].layout == "none" then
    "[con_id=\(.nodes[0].id)] splith"
  else
    "nop"
  end;
  # TODO move rest 


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
  workspace
  | singleton
  | (.nodes | length) as $n
  | (if $n > 2 then
      [.nodes[2:]
        | .[]
        | tiles
        | "[con_id=\(.id)] move container to mark insert"]
      | join("; ")
    else
      "nop"
    end) as $overflow
  | (if .nodes | length > 1 then
      .nodes[0]
      | when(.layout == "none"; "[con_id=\(.id)] split toggle")
    else
      "nop"
    end) + "; " + $overflow;



def event_window_focus($tree):
  "nop";
