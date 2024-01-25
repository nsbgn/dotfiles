#!/usr/bin/env python3

# polybar/lemonbar have no Wayland support; waybar/yambar can only set onclicks
# for entire modules/particles, with no way to automatically generate multiple
# particles in a single custom script (except for making an actual module, 
# which is too much effort for this prototype). Try also 
# <https://github.com/JakeStanger/ironbar>

# Perhaps I will update it at some point. This script can be used as a 
# `status_command` for the i3bar or swaybar. Inspiration:
# -   <https://github.com/tobi-wan-kenobi/bumblebee-status>


# Unicode stuff:
# Powerline symbols:   
# Legacy computing: 🭮🭋🭛🭬
# ❴❵ ❨❩ ❲❳ ❬❭ ⦃ ⦄ ⦆⦑⦁∘⧼⧽⧸⧹∙⋯
# ┋│
# ⸨⸩⫽
# ⟨⟩
# ⬤ (2b24) or ⭕ (2b55) or ⭘ (2b58) or *️⃣ or 🔲⬛
# 🅐 (1F150) or Ⓐ  (24B6) or 🅰 (1F170) or 🄰 (1F130)
# Cozette: ⟨⟦⟧⟩

import sys
import os.path
sys.path.append(os.path.expanduser('~/.scripts'))

import html
import i3ipc as i3  # type: ignore
import i3ipc_extension as i3e
from typing import Iterator
from itertools import chain, pairwise

invert = "<span foreground='#000000' background='#ffffff'>"
revert = "</span>"


class Window(object):
    def __init__(self, title: str, focus: bool = False) -> None:
        self.title: str = title
        self.focus: bool = focus
        self.floating: bool = False
        self.mark: str | None = None


def marks(*marks: str, open: bool = False) -> str:
    marks = tuple(m for m in marks if not m.startswith("_"))
    if not marks:
        return "\ueffd" if open else "■"
    elif "A" <= marks[0] and marks[0] <= "Z":
        return chr((0x1f150 if open else 0x1f170) + ord(marks[0]) - 0x41)
    else:
        return f"⟬{', '.join(marks)}⟭" if open else f"❨{', '.join(marks)}❩"


def subscript(i: int) -> str:
    # Could also use <sub> in Pango, but Unicode is more general
    # 0x2050 is ord('₀') - ord('0')
    return "".join(chr(0x2050 + ord(d)) for d in str(i))


def window(win: i3.Con) -> str:
    assert win.type.endswith("con") and not (win.nodes or win.floating_nodes)
    app = win.app_id or win.window_class
    if app == "Firefox-esr":
        label = "web"
    else:
        label = html.escape(win.name.strip())

    return f' {label} '


def workspace(ws: i3.Con) -> Iterator[str]:
    assert ws.type == "workspace"
    scratch = ws.name == "__i3_scratch"

    windows = list(chain(ws.leaves(), ws.floating_nodes))

    yield '' if (windows and windows[0].focused) or ws.focused else ''
    if not scratch and not windows:
        yield f'{invert} ⋯ {revert}' if ws.focused else ' ⋯ '
    for w, cur in enumerate(windows):
        if cur.focused:
            yield invert
        if w:
            prev = windows[w - 1]
            if prev.focused or cur.focused:
                # Same for both since if cur.focused, the colors have inverted
                yield "▌"
            elif prev.type == "con" and cur.type == "floating_con":
                yield "┃"
            else:
                yield "┊"
        yield window(cur)
        if cur.focused:
            yield revert
    yield '' if (windows and windows[-1].focused) or ws.focused else ''

    if not scratch:
        yield subscript(ws.num)


conn = i3e.Connection("taskbar", auto_reconnect=True)


@conn.handle_event(i3.Event.WINDOW_FOCUS, i3.Event.WINDOW_NEW,
    i3.Event.WINDOW_CLOSE, i3.Event.WINDOW_MARK, i3.Event.WINDOW_TITLE,
    i3.Event.WORKSPACE_FOCUS)
def taskbar(event: i3.Event) -> None:
    tree: i3.Con = conn.get_tree()

    for ws in tree.workspaces():
        for x in workspace(ws):
            sys.stdout.write(x)
        sys.stdout.write("  ")

    scratchpad = tree.scratchpad()
    for w in scratchpad.floating_nodes:
        for x in window(w):
            sys.stdout.write(x)
        sys.stdout.write("  ")

    sys.stdout.write('\n')
    sys.stdout.flush()


if __name__ == "__main__":
    conn.main()
