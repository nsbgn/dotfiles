include "i3/prelude";

def mark_after: mark("insert");
def mark_before: mark("insert", "swap");

# Enforce a layout that puts a stack of windows on the first container and a 
# single (main?) window on the second

def make_stack:
  assert(.layout == "none") |
  "[con_id=\(.id)] mark insert; [con_id=\(.id)] splitv; [con_id=\(.id)] layout stacking";

def normalize:
  workspace
  | (.nodes | length) as $n
  | if $n == 0 then
      "unmark swap; unmark insert"
    elif $n == 1 then
      .nodes[0]
      | if .layout == "none" then
          mark("swap")
        else
          if (.nodes | length) < 2 then
            .nodes[0] | "[con_id=\(.id)] split none; \(mark("swap"))"
          else
            "[con_id=\(descend_n(1).id)] move right"
          end
      end
    else
      .nodes[0]
      | if .layout == "none" then
          make_stack
        else
          window | "unmark swap; \(mark("insert"))"
        end
    end;

def event_workspace_focus($tree):
  $tree | normalize;

def event_window_new($tree):
  $tree | normalize;

def event_window_close($tree):
  $tree | normalize;
