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

terminals = {
    "URxvt"
}

default_icon = "?"
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


def on_focus_change() -> Iterator[Event]:
    """
    Emit an event when window focus changes.
    """
    root.change_attributes(event_mask=X.PropertyChangeMask)
    while True:
        event = display.next_event()
        if event.type == X.PropertyNotify and event.atom == _NET_ACTIVE_WINDOW:
            yield event


def associated_processes(window_id: int) -> Iterator[psutil.Process]:
    """
    Find the processes associated with a particular window.
    """
    wid = str(window_id)
    for process in psutil.process_iter(['environ']):
        env = process.info.get('environ')
        if env and env.get('WINDOWID') == wid:
            yield process


def process_icon(window_id: int) -> Optional[str]:
    """
    Get an icon for the most recent process for which there is an icon.
    """
    for process in reversed(list(associated_processes(window_id))):
        name = process.name()
        if name in icons:
            return icons[name]


if __name__ == '__main__':

    for _ in on_focus_change():

        active_wid = root.get_full_property(
            _NET_ACTIVE_WINDOW, X.AnyPropertyType).value[0]

        active_ws = root.get_full_property(
            _NET_CURRENT_DESKTOP, X.AnyPropertyType).value[0]

        client_list = root.get_full_property(
            _NET_CLIENT_LIST, property_type=X.AnyPropertyType,
        ).value

        current_desktop = 0

        # Prepare icons for every window
        for window_id in client_list:
            window = display.create_resource_object('window', window_id)
            instance, cls = window.get_wm_class()
            desktop = window.get_full_property(
                _NET_WM_DESKTOP, property_type=X.AnyPropertyType).value[0]

            if cls in terminals:
                icon = process_icon(window_id)
            else:
                icon = icons.get(cls)

            print(window, desktop, cls, icon or default_icon)
