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
# See
# https://unix.stackexchange.com/questions/260162/how-to-track-newly-created-processes-in-linux
# for monitoring processes for child processes? I suppose the easiest way is to
# only examine the previously focused window for processes, whie the default
# urxvt icon is used for the focused window.
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
icons_ = {
    "": ["Firefox-esr"],
    "": ["nvim"],
    "": ["lf"],
    "": ["urxvt"],
    "": ["aerc", "mutt"],
}
icons = {k: v for v, ks in icons_.items() for k in ks}


# Connect to X
display = Display()
root = display.screen().root
_NET_ACTIVE_WINDOW = display.intern_atom('_NET_ACTIVE_WINDOW')
_NET_CURRENT_DESKTOP = display.intern_atom("_NET_CURRENT_DESKTOP")
_NET_CLIENT_LIST = display.get_atom('_NET_CLIENT_LIST')
_NET_WM_DESKTOP = display.get_atom('_NET_WM_DESKTOP')
_NET_NUMBER_OF_DESKTOPS = display.get_atom('_NET_NUMBER_OF_DESKTOPS')


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
        return None

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


COLOR_BG = "#ead6b8"
COLOR_ACTIVE_FG = "#403935"
COLOR_ACTIVE_BG = "#cab698"  # "#F5ECDE"
COLOR_INACTIVE_BG = "#dac6a8"


if __name__ == '__main__':

    for _ in on_focus_change():
        active_wid = root.get_full_property(
            _NET_ACTIVE_WINDOW, X.AnyPropertyType).value[0]
        active_ws = root.get_full_property(
            _NET_CURRENT_DESKTOP, X.AnyPropertyType).value[0]
        num_workspaces = root.get_full_property(
            _NET_NUMBER_OF_DESKTOPS, X.AnyPropertyType).value[0]

        workspaces = [[] for _ in range(num_workspaces)]

        for window in Window.clients():
            string = (
                f"%{{A1:xdotool windowactivate {window.wid}:}}"
                f"%{{O5}}{window.icon()}%{{O5}}%{{A}}"
            )
            if window.wid == active_wid:
                string = f"%{{B{COLOR_ACTIVE_BG}}}%{{R}}" + string + "%{R}%{B-}"
            else:
                string = f"%{{B{COLOR_INACTIVE_BG}}}" + string + "%{B-}"
                # #DBB884
            string = "%{O2}" + string + "%{O2}"
            workspaces[window.workspace()].append(string)

        # #c95c5a
        # #ead6b8
        # #6b918e
        # #ffffee
        # #403935

        dbetween = "%{O8}%{B#f00}%{O10}%{B-}%{O8}"

        for i, workspace in enumerate(workspaces):
            print(f"%{{O5}}%{{U{COLOR_BG}}}%{{+o}}%{{+u}}", end='')
            if workspace:
                print("".join(workspace), end='')
            else:
                if i == active_ws:
                    print(f"%{{B{COLOR_ACTIVE_BG}}}%{{R}}", end='')
                else:
                    print(f"%{{B{COLOR_INACTIVE_BG}}}", end='')
                print(f"%{{A1:xdotool set_desktop {i}:}}%{{O22}}%{{A}}", end='')
                if i == active_ws:
                    print("%{R}%{B-}", end='')
                else:
                    print("%{B-}", end='')
            print("%{-o}%{-u}%{O5}", end='')
        print(flush=True)
