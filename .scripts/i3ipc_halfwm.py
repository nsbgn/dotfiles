#!/usr/bin/env python3
# swaymsg gaps horizontal current set 600
"""
This is a set of commands to reduce the mental overhead of using Sway and i3. 
Each virtual desktop becomes a carousel that shows at most two windows.

Rationale: I don't find myself ever benefiting from having more than two 
windows open on the same screen at any one time. (Maybe three, if there's a 
video playing and I pretend to multitask.) So, rather than manually arranging 
windows, or implementing elaborate and abstract ways to do so automatically, I 
think it's better to go for a more tangible metaphor: every desktop shows only 
the active window, plus, optionally, a reference window to the side of it. It 
is tiled horizontally if the aspect ratio exceeds 1, and vertically otherwise.

What I try to make easier is not the *layout*, but leafing through the pile to 
find the sheet you need. I try to keep the amount of keyboard shortcuts or 
touchscreen gestures small. Every window gets automatically assigned a 
one-letter label, so that you can instantly bring it to focus. In addition to 
the static labels, there is one dynamic label that switches between the active 
and reference windows, and two that cycle forward or backward through the 
inactive windows.

To stay as environment-agnostic as possible, command should make just as much 
sense on stacking window managers (Wayfire/labwc) or terminal multiplexers 
(tmux).
"""

import sys
import os.path
sys.path.append(os.path.expanduser('~/.scripts'))

import i3ipc as i3  # type: ignore
import i3ipc_extension as i3e
import i3ipc_tree as i3t
from typing import Iterator, Literal
from collections import deque


# globals
minimized: deque[i3.Con] = deque()
preferred_size = {
    "footclient": (400, 1)
}
conn = i3e.Connection("halfwm", auto_reconnect=True)


def windows_floating(tree: i3.Con) -> list[i3.Con]:
    focus = tree.find_focused()
    ws = focus.workspace()
    return ws.floating_nodes


def windows_hidden(tree: i3.Con) -> list[i3.Con]:
    scratch = tree.find_named("__i3_scratch")[0]
    return scratch.floating_nodes


def windows_tiled(tree: i3.Con) -> list[i3.Con]:
    focus = tree.find_focused()
    ws = focus.workspace()
    return ws.nodes


# @conn.handle_event(i3.Event.WINDOW_FOCUS, i3.Event.WINDOW_NEW)
def window_focus(event: i3.Event) -> None:
    tree: i3.Con = conn.get_tree()
    hidden = windows_hidden(tree)
    floating = windows_floating(tree)
    tiled = windows_tiled(tree)
    print("***")
    print("Hidden windows:", [c.id for c in hidden])
    print("Tiled windows:",
      " ".join(f"{c.id}{'*' if c.focused else ' '}" for c in tiled))
    print("Floating windows:",
      " ".join(f"{c.id}{'*' if c.focused else ' '}" for c in floating))


@conn.handle_message("swap")
def swap(direction: Literal['previous', 'next']) -> Iterator[str]:
    """Swap currently focused window with one of the minimized windows."""
    global minimized
    tree = conn.get_tree()
    old = tree.find_focused()

    if not minimized or not (conn.last_msg_command[0] == "swap"
            and conn.last_msg_command[1] in ("next", "prev")):
        minimized = deque(windows_hidden(tree))

    if dir == 'next':
        new = minimized.popleft()
        minimized.append(old)
    else:
        new = minimized.pop()
        minimized.appendleft(old)

    yield f"[con_id={new.id}] focus"
    yield f"[con_id={old.id}] swap container with con_id {new.id}"
    yield f"[con_id={old.id}] move to scratchpad"

# @conn.handle_message("focus")
# def focus(area: Literal['tile', 'float', 'scratch'],
#           idx: str | None = None) -> Iterator[str]:
#     """Focus on a window on the current desktop, additionally unminimizing it 
#     if it is currently minimized.

#     Usage: focus (tile|float|scratch) [1…|prev|next]"""

#     global minimized
#     tree = conn.get_tree()
#     focus = tree.find_focused()
#     ws = focus.workspace()

#     if not (conn.last_cmd[0] == "focus"
#             and conn.last_cmd[1] in ("next", "prev")):
#         minimized = windows_hidden(tree)

#     n = len(ws.nodes)
#     if area == 'tile':
#         i = ws.nodes[int(idx) % n].id if idx else ws.focus[0]
#         yield f'[con_id={i}] focus'
#     elif area == 'float':
#         pass


# @conn.handle_message("push")
# def push(area: Literal['tiled', 'floating'], idx: str) -> None:
#     """Minimize the target window and put the currently focused window in its 
#     place.

#     Usage: push (tile|float) [1…] [current|auxiliary]"""

#     assert area in ("first", "second")

#     tree = conn.get_tree()
#     focus = tree.find_focused()
#     assert focus

#     ws = focus.workspace()
#     if focus.is_floating():

#         tiles = ws.nodes
#         if len(tiles) == 0:
#             pass
#         elif len(tiles) == 1:
#             pass
#         elif len(tiles) == 2:
#             pass

#     else:
#         pass

#     # children = tree.nodes
#     # yield ''
#     # x = args[0]
#     # if x == 'first':
#     #     yield ''
#     # elif x == 'second':
#     #     yield ''

if __name__ == "__main__":
    conn.send_tick("halfwm exit")
    conn.main()
