include "i3/prelude";

def mark_after: mark("insert");
def mark_before: mark("insert", "swap");

# Enforce a layout that puts a stack of windows on the first container and a 
# single (main?) window on the second

def make_stack:
  assert(.layout == "none") |
  "[con_id=\(.id)] mark insert; [con_id=\(.id)] splitv; [con_id=\(.id)] layout stacking";

def enter:
  workspace
  | if (.nodes | length) == 1 then
      .nodes[0] | mark_before
    elif (.nodes | length) >= 2 then
      .nodes[0] # enter into stack
      | if .layout == "none" then
          make_stack
        else
          descend_n(0) | mark_after
        end
    else
      "nop"
    end;

def close:
  workspace
  | if .nodes == [] then
      "nop"
    elif (.nodes | length) == 1 then
      .nodes[0]
      | if .layout == "none" then
          mark_before
        else
          if (.nodes | length) >= 2 then
            "[con_id=\(descend_n(1).id)] move right"
          else
            .nodes[0] | "[con_id=\(.id)] split none; \(mark_before)"
          end
      end
    else
      .nodes[0]
      | if .layout == "none" then
          make_stack
        else
          descend_n(0) | window | mark_after
        end
    end;

def normalize(f):
  "unmark insert; unmark swap; \(f)";

def event_workspace_focus($tree):
  $tree | normalize(enter);

def event_window_new($tree):
  $tree | normalize(enter);

def event_window_move($tree):
  $tree | normalize(enter);

def event_window_close($tree):
  $tree | normalize(close);
