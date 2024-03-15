include "i3/prelude";

def ensure_layout:
  assert(.type == "workspace")
  | if (.nodes | length) == 1 then
      "[con_id=\(.nodes[0].id)] mark insert_before"
    elif (.nodes | length) >= 2 then
      .nodes[0] # enter into stack
      | if .layout == "none" then
          "[con_id=\(.id)] mark insert; [con_id=\(.id)] splitv"
        else
          if (.nodes | length) >= 2 then
            .nodes[1] # enter into pile
            | if .layout == "none" then
                "[con_id=\(.id)] split toggle; [con_id=\(.id)] layout stacking; [con_id=\(.id)] mark insert"
              else
                last(tiles) | "[con_id=\(.id)] mark insert"
              end
          else
            "nop"
          end
        end
    else
      "nop"
    end;

def normalize:
  workspace | "unmark insert; unmark insert_before; \(ensure_layout // "nop")";

def event_workspace_focus($tree):
  $tree | normalize;

def event_window_new($tree):
  $tree | workspace | normalize;

# def event_window_move($tree):
#   "[con_id=\(.id)] move container to mark insert_before; [con_id=\(.id)] move container to mark insert";
