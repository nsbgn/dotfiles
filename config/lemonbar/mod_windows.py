#!/usr/bin/env python3
"""
This module continuously outputs a list of windows as they change, with the
most appropriate icon it can find --- even for terminal applications. It is a
work-in-progress!
"""
# The following script from Stephan Sokolow was a huge help:
# https://gist.github.com/ssokolow/e7c9aae63fb7973e4d64cff969a78ae8
# Also see the documentation at:
# https://specifications.freedesktop.org/wm-spec/1.3/ar01s03.html
# This is based on an idea in an old script of mine, see:
# https://github.com/slakkenhuis/scripts/blob/68e846d12ffb6b9aaf0239f0900322847a3f5ee2/xcwd.sh
#
# If you were to try this in bash, you mightuse this to monitor changes:
# `xprop -root -spy _NET_CLIENT_LIST _NET_ACTIVE_WINDOW`
# ... this to find processes:
# `ps e -N --ppid 1 --sort=+pid -o args | grep "WINDOWID=$((16#${WID#0x}))"`
# ... and this to get the list of client windows:
# `while IFS="[ .\.]" read -r WID WS INST CLS HOST TITLE; ... < <(wmctrl -lx)`

import psutil
from Xlib.display import Display
from Xlib import X
from typing import Iterator, Optional
from Xlib.protocol.rq import Event
from itertools import groupby

terminals = {
    "URxvt"
}

default_icon = ""
icons = {
    "": ["Firefox-esr"],
    "": ["nvim"],
    "": ["lf"],
    "": ["urxvt"],
    "": ["aerc", "mutt"],
}
icons = {k: v for v, ks in icons.items() for k in ks}


# Connect to X
display = Display()
root = display.screen().root
_NET_ACTIVE_WINDOW = display.intern_atom('_NET_ACTIVE_WINDOW')
_NET_CURRENT_DESKTOP = display.intern_atom("_NET_CURRENT_DESKTOP")
_NET_CLIENT_LIST = display.get_atom('_NET_CLIENT_LIST')
_NET_WM_DESKTOP = display.get_atom('_NET_WM_DESKTOP')


def on_focus_change() -> Iterator[Optional[Event]]:
    """
    Emit an event when window focus changes.
    """
    yield None
    root.change_attributes(event_mask=X.PropertyChangeMask)
    while True:
        event = display.next_event()
        if event.type == X.PropertyNotify and event.atom == _NET_ACTIVE_WINDOW:
            yield event


class Window(object):

    cache: dict[int, 'Window'] = dict()

    def __init__(self, window_id: int):
        self.wid = window_id
        self.obj = display.create_resource_object('window', window_id)
        self.ins, self.cls = self.obj.get_wm_class()
        self._process = None

    def workspace(self) -> int:
        return self.obj.get_full_property(
            _NET_WM_DESKTOP, property_type=X.AnyPropertyType).value[0]

    def icon(self) -> str:
        """
        Get an icon for the most recent process for which there is an icon.
        """
        if self.cls in terminals:
            for process in reversed(list(self.process().children())):
                name = process.name()
                if name in icons:
                    return icons[name]
        return icons.get(self.cls, default_icon)

    def process(self) -> Optional[psutil.Process]:
        """
        Find the first process associated with this particular window.
        """
        if self._process:
            return self._process
        wid = str(self.wid)
        for process in psutil.process_iter(['environ']):
            env = process.info.get('environ')
            if env and env.get('WINDOWID') == wid:
                self._process = process
                return process

    @staticmethod
    def clients() -> list['Window']:
        result = []
        for client_id in root.get_full_property(
                _NET_CLIENT_LIST, property_type=X.AnyPropertyType,
                ).value:
            result.append(Window.get(client_id))
        Window.cache = {w.wid: w for w in result}
        return result

    @staticmethod
    def get(i: int) -> 'Window':
        return Window.cache.get(i) or Window(i)


if __name__ == '__main__':

    for _ in on_focus_change():
        active_wid = root.get_full_property(
            _NET_ACTIVE_WINDOW, X.AnyPropertyType).value[0]
        active_ws = root.get_full_property(
            _NET_CURRENT_DESKTOP, X.AnyPropertyType).value[0]

        for ws, windows in groupby(Window.clients(), Window.workspace):
            print("%{+u}", end='')
            for window in windows:
                if window.wid == active_wid:
                    print("%{R}", end='')
                print(f"%{{A1:xdotool windowactivate {window.wid}:}}", end='')
                print(f"%{{O10}}{window.icon()}%{{O10}}", end='')
                print("%{A}", end='')
                if window.wid == active_wid:
                    print("%{R}", end='')
            print("%{-u}%{O12}", end='')
        print(flush=True)
