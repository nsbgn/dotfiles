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
import i3ipc_util as i3u
from typing import Iterator


conn = i3e.Connection("halfwm", auto_reconnect=True)


@conn.handle_message("minimize")
def minimize() -> Iterator[str]:
    """Move currently focused window to minimized."""
    tree = conn.get_tree()
    win = tree.find_focused()

    if win:
        ws = i3u.current_workspace(tree)
        before, after = i3u.get_minimized(ws)
        if after:
            _, a = i3u.find_position(after[0]) or (0, 0)
        else:
            a = 0

        yield f"[con_id={win.id}] mark _ws{ws.num}_pos{a+1}"
        yield f"[con_id={win.id}] move to scratchpad"


@conn.handle_message("leaf")
def leaf(δ: str = "1") -> Iterator[str]:
    tree = conn.get_tree()
    ws = i3u.current_workspace(tree)
    leaves = ws.leaves()
    if leaves:
        i = next(i for i, w in enumerate(leaves) if w.focused)
        j = i + int(δ)
        if j > 0 and j < len(leaves):
            yield f"[con_id={leaves[j].id}] focus"


@conn.handle_message("next")
def next_w() -> Iterator[str]:
    tree = conn.get_tree()
    ws = i3u.current_workspace(tree)
    win = tree.find_focused()
    before, after = i3u.get_minimized(ws)
    if win and after:
        _, a = i3u.find_position(after[0]) or (None, None)
        if before:
            _, b = i3u.find_position(before[-1]) or (0, 0)
        else:
            b = 0

        yield f"[con_id={after[0].id}] swap container with con_id {win.id}"
        if a:
            yield f"[con_id={after[0].id}] unmark _ws{ws.num}_pos{a}"
        yield f"[con_id={win.id}] mark --add _ws{ws.num}_pos{b-1}"


@conn.handle_message("prev")
def prev_w() -> Iterator[str]:
    tree = conn.get_tree()
    ws = i3u.current_workspace(tree)
    win = tree.find_focused()
    before, after = i3u.get_minimized(ws)
    if win and before:
        _, b = i3u.find_position(before[-1]) or (None, None)
        if after:
            _, a = i3u.find_position(after[0]) or (0, 0)
        else:
            a = 0

        yield f"[con_id={before[-1].id}] swap container with con_id {win.id}"
        if b:
            yield f"[con_id={before[-1].id}] unmark _ws{ws.num}_pos{b}"
        yield f"[con_id={win.id}] mark --add _ws{ws.num}_pos{a+1}"


if __name__ == "__main__":
    conn.main()
