import re
import i3ipc as i3  # type: ignore

ws_position = re.compile(r'_ws([0-9]+)_pos(-?[0-9]+)')


def current_workspace(tree: i3.Con) -> i3.Con:
    focused = tree.find_focused()
    if focused:
        ws = focused.workspace()
    else:
        ws = next(ws for ws in tree.workspaces() if ws.focused)
    assert ws.type == "workspace"
    return ws


def find_position(win: i3.Con) -> tuple[int, int] | None:
    """Find the workspace & position associated with a scratchpad window."""
    # assert win.parent.name == "__i3_scratch"
    for mark in win.marks:
        if (m := ws_position.match(mark)):
            return int(m[1]), int(m[2])
    return None


def get_minimized(tree: i3.Con) -> tuple[list[i3.Con], list[i3.Con]]:
    """Get the minimized windows associated with the current workspace in the 
    proper order."""
    ws = tree if tree.type == "workspace" else current_workspace(tree)
    scratchpad = tree.scratchpad().floating_nodes

    before: list[tuple[int, i3.Con]] = []
    after: list[tuple[int, i3.Con]] = []
    for win in scratchpad:
        assoc = find_position(win)
        w, pos = assoc or (ws.num, 0)
        if w == ws.num:
            if pos < 0:
                before.append((pos, win))
            else:
                after.append((pos, win))
    return [x[1] for x in reversed(sorted(before))], [
        x[1] for x in reversed(sorted(after))]
