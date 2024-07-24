# Work in progress

import "i3jq@ipc" as ipc;
import "i3jq@tree" as tree;

def toggle:
  ipc::do(
    ipc::get_tree |
    tree::focus |
    if .type == "floating_con" then
      "floating disable",
      "sticky disable",
      "border normal 0"
    else
      "floating enable",
      "sticky enable",
      "border normal 2"
    end
  );

"Use with `toggle`"
