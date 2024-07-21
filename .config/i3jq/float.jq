# Work in progress

import "i3jq@ipc" as ipc;
import "i3jq@tree" as tree;

def focus:
  ipc::do("focus mode_toggle")
;

def toggle:
  ipc::do(
    ipc::get_tree |
    tree::focus |
    if .type == "floating_con" then
      "floating disable"
    else
      "floating enable"
    end
  );

"Use with `toggle`"
