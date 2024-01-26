#!/usr/bin/env python3
"""
This script automatically 
"""

import sys
from itertools import count
from typing import Iterable, Iterator
from time import time

import i3ipc as i3  # type: ignore
import i3ipc_extension as i3e

INTERVAL = 0.2

if len(sys.argv) > 1:
    MARKERS = list(set(sys.argv[1].upper()))
else:
    MARKERS = list("ABCDEFGHIJKLMNOPQRSTUVWXYZ")


def get_new_mark(exclude: Iterable[str]) -> str:
    for i in count():
        prefix = i * 'b'
        for m in MARKERS:
            mark = prefix + m
            if mark not in exclude:
                return mark
    raise RuntimeError("unreachable state")


class Connection(i3e.Connection):

    def __init__(self, *nargs, **kwargs) -> None:
        self.mark_path = ""
        self.mark_time = 0.0
        super().__init__(*nargs, **kwargs)

    def reassign_mark(self, mark: str) -> Iterator[str]:
        """Give the currently focused window a specific mark. If that 
        overwrites an existing mark, give the old window a new mark too."""
        current_marks = self.get_marks()
        if mark in current_marks:
            yield f"[con_mark={mark}] mark {get_new_mark(current_marks)}"
        yield "f[{con_id=__focused__]"

    def mark_focus(self, mark: str) -> Iterator[str]:
        """Focus on a window with a particular mark, or refine an earlier call 
        to this command."""
        now = time()
        if now - self.mark_time <= INTERVAL:
            self.mark_path = mark = self.mark_path + mark
        else:
            self.mark_path = ""
        self.mark_time = now

        mark = mark.upper()
        current_marks = self.get_marks()

        # If there is a mark that matches exactly, just focus on it
        if mark in current_marks:
            yield f"[con_mark={mark}] focus"

        # If there are containers with marks to which the current mark is a 
        # prefix, we focus on the first one we find if we descend in focus 
        # order; later calls to mark_focus may refine this.
        elif any(m.startswith(mark) for m in current_marks):
            tree = self.get_tree()
            for leaf in focus_order(tree):
                if any(m.startswith(mark) for m in leaf.marks):
                    yield f"[con_id={leaf.id}] focus"
                    break
        else:
            self.mark_time = 0.0


conn = Connection("automark", auto_reconnect=True)


def add_markers() -> Iterator[str]:
    """Add markers to existing windows."""
    current_marks = conn.get_marks()
    tree = conn.get_tree()
    for leaf in tree.descendants():
        if (leaf.nodes or leaf.floating_nodes
                or leaf.type not in ('con', 'floating_con')):
            continue
        marks = leaf.marks
        if not marks:
            new_mark = get_new_mark(current_marks)
            current_marks.append(new_mark)
            yield f"[con_id={leaf.id}] mark {new_mark}"


@conn.handle_event(i3.Event.WINDOW_NEW)
def add_marker(event: i3.WindowEvent) -> Iterator[str]:
    """An event handler that adds a marker to every new window."""
    con_id = event.container.id
    current_marks = conn.get_marks()
    new_mark = get_new_mark(current_marks)
    yield f"[con_id={con_id}] mark {new_mark}"

    # if cmd == "focus_mark":
    #     yield from self.mark_focus(command[2])
    # elif cmd == "focus_mark_aux":
    #     raise NotImplementedError
    # elif cmd == "cycle":
    #     raise NotImplementedError
    # elif cmd == "cycle_aux":
    #     raise NotImplementedError
    # elif cmd == "swap_aux":
    #     raise NotImplementedError
    # elif cmd == "toggle_aux":
    #     yield from self.toggle()
    # elif cmd == "balance":
    #     raise NotImplementedError
    # conn.on(i3.Event.TICK, Connection.execute_commands)
    # execute(conn, conn.add_markers())


conn.execute(add_markers())
conn.main()
