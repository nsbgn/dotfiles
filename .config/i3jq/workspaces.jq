# Cycle through workspaces, always visiting an empty workspace in between.

import "i3jq@ipc" as ipc;
import "i3jq@tree" as tree;

def goto($n): null;

"Use with `previous` or `next`"
