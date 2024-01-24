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

import sys
import os.path
sys.path.append(os.path.expanduser('~/.scripts'))

import html
import i3ipc as i3  # type: ignore
import i3ipc_extension as i3e
from typing import Iterator
from itertools import chain, pairwise


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
    return "".join(chr(0x2080 - 0x30 + ord(d)) for d in str(i))


def window(win: i3.Con) -> str:
    assert win.type.endswith("con") and not (win.nodes or win.floating_nodes)
    app = win.app_id or win.window_class
    if app == "Firefox-esr":
        label = "web"
    else:
        label = html.escape(win.name.strip())

    if win.focused:
        return (
            f'\ue0b6<span foreground="#000000" background="#ffffff">'
            f'{label}</span>\ue0b4')
    else:
        return f'\ue0b7{label}\ue0b5'

    # if win.focused:
    #     return f'{marks(*win.marks, open=False)} (<b>{label}</b>)'
    # else:
    #     return f'{marks(*win.marks, open=True)}  {label} '


def workspace(ws: i3.Con) -> Iterator[str]:
    assert ws.type == "workspace"
    scratch = ws.name == "__i3_scratch"

    focused = ws.focused or ws.find_focused()

    # if focused:
    #     yield '<span foreground="#000000" background="#ffffff">'

    yield " ⟨ " if scratch else " ⟦ "
    # yield from span("⟦ ", font_size="15pt", line_height="0.5", fgalpha="100%" 
    #                 if focused else "70%")

    if not scratch and not (ws.floating_nodes or ws.nodes):
        yield '*' # ⋯
    else:
        yield " · ".join(window(w) for w in ws.leaves())
        if ws.floating_nodes and ws.nodes:
            yield " "
        yield "   ".join(window(w) for w in ws.floating_nodes)
    yield " ⟩" if scratch else " ⟧"
    # yield from span(" ⟧", font_size="15pt", line_height="0.5", 
    #     fgalpha="100%" if focused else "70%")
    # yield f'<sup><span size="larger">{ws.num}</span></sup>'
    if not scratch:
        yield subscript(ws.num)
    # yield " "

    # if focused:
    #     yield "</span>"


def span(text: str, fg: int | None = None,
         bg: int | None = None, **kwargs) -> Iterator[str]:
    yield "<span"
    if fg:
        yield f' foreground="#{fg:06x}"'
    if bg:
        yield f' background="#{bg:06x}"'
    for k, v in kwargs.items():
        yield f' {k}="{v}"'
    yield '>'
    yield text
    yield "</span>"


conn = i3e.Connection("taskbar", auto_reconnect=True)


@conn.handle_event(i3.Event.WINDOW_FOCUS, i3.Event.WINDOW_NEW,
    i3.Event.WINDOW_CLOSE, i3.Event.WINDOW_MARK, i3.Event.WINDOW_TITLE,
    i3.Event.WORKSPACE_FOCUS)
def taskbar(event: i3.Event) -> None:
    tree: i3.Con = conn.get_tree()
    leaves = ["".join(workspace(w)) for w in tree.workspaces()]
    scratchpad = tree.scratchpad()
    loofs = "".join(workspace(scratchpad))
    print("  ".join(leaves) + "   " + loofs, flush=True)


if __name__ == "__main__":
    conn.main()
