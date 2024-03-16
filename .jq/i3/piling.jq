include "i3/prelude";

# Enforce a layout that puts a stack of windows on the first container and a 
# single (main?) window on the second

def enter:
  workspace
  | if (.nodes | length) == 1 then
      "[con_id=\(.nodes[0].id)] mark insert_before"
    elif (.nodes | length) >= 2 then
      .nodes[0] # enter into stack
      | if .layout == "none" then
          "[con_id=\(.id)] mark insert; [con_id=\(.id)] splitv; [con_id=\(.id)] layout stacking"
        else
          last(tiles) | "[con_id=\(.id)] mark insert"
        end
    else
      "nop"
    end;

def close:
  workspace
  | if (.nodes | length) == 1 then
      if .nodes[0].layout == "none" then
        "[con_id=\(.nodes[0].id)] mark insert_before"
      else
        .nodes[0] # enter the stack
        | if (.nodes | length) == 1 then
            "[con_id=\(.nodes[0].id)] split none; [con_id=\(.nodes[0].id)] mark insert_before"
          else
            "[con_id=\(.nodes[-1].id)] move right; [con_id=\(.nodes[-2].id)] mark insert"
          end
      end
    else
      .nodes[0]
      | if .layout == "none" then
          "[con_id=\(.id)] mark insert; [con_id=\(.id)] splitv; [con_id=\(.id)] layout stacking"
        else
          "[con_id=\(.nodes[-1].id)] mark insert"
        end
    end;

def normalize(f):
  "unmark insert; unmark insert_before; \(f)";

def event_workspace_focus($tree):
  $tree | normalize(enter);

def event_window_new($tree):
  $tree | normalize(enter);

def event_window_move($tree):
  $tree | normalize(enter);

def event_window_close($tree):
  $tree | normalize(close);
