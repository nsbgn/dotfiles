#!/usr/bin/env python3

# polybar/lemonbar have no Wayland support; waybar/yambar can only set onclicks
# for entire modules/particles, with no way to automatically generate multiple
# particles in a single custom script (except for making an actual module, 
# which is too much effort for this prototype). Try also 
# <https://github.com/JakeStanger/ironbar>. Ideal would be something like 
# lemonbar for wayland, eg <https://git.sr.ht/~novakane/zelbar>, if it was 
# widely packaged.

# Perhaps I will update it at some point. This script can be used as a 
# `status_command` for the i3bar or swaybar. Inspiration:
# -   <https://github.com/tobi-wan-kenobi/bumblebee-status>

# ❴❵ ❨❩ ❲❳ ❬❭ ⦃ ⦄ ⦆⦑⦁∘⧼⧽⧸⧹∙⋯ ┋│ ⸨⸩⫽ ⟨⟩
# ⬤ (2b24) or ⭕ (2b55) or ⭘ (2b58) or *️⃣ or 🔲⬛
# 🅐 (1F150) or Ⓐ  (24B6) or 🅰 (1F170) or 🄰 (1F130)
# Cozette: ⟨⟦⟧⟩
# Legacy computing: 🭮🭋🭛🭬
# Powerline:  

import sys
import os.path
sys.path.append(os.path.expanduser('~/.scripts'))

import html
import i3ipc as i3  # type: ignore
import i3ipc_extension as i3e
from typing import Iterator
from itertools import chain

invert = "<span foreground='#000000' background='#ffffff'>"
revert = "</span>"

# Associate emojis with applications
icons = {
    "🌐": ["Firefox-esr"],  # fa: 
    "🗒️": ["vi", "vim", "neovim"],
    "⚒️": ["something"],
    "🧭": ["mepo"],
    "🗺️": ["QGIS"],
    "🔖": ["sqlitebrowser"],
    "📁": ["lf"],
    "🖥️": ["foot"],  # fa: 
    "💬": ["telegram-desktop"],
    "✉️": ["aerc"],
    "📫": ["thunderbird"],
    "📺": ["youtube"],
    "💾": ["nicotine", "transmission"],
    "🧮": ["Calculator"],
    "📊": ["LibreOffice Calc"],
    "📄": ["LibreOffice Writer"],
    "📽": ["LibreOffice Impress"],
    "🔬": ["RStudio"],
    "🖼️": ["imv"],
    "📅": ["khal"],
    "👥": ["khard"],
    "🎨": ["GIMP", "krita"],
    "🖌️": ["inkscape"],
    "🎞️": ["mpv"],
    "🎬": ["Kdenlive"],
    "🔑": ["gnome-keyring"],
    "🔐": ["gnupg"],
    "🛡": ["firewall"],
    "📖": ["zathura", "mupdf"],
    "📑": ["sigil"],
    "📝": ["xournalpp"],
    "⚙️": ["settings"],
    "🕹️": ["dolphin-emu", "mgba", "OpenMW"],
    "*️ ": ["default"]  # fa: 
}


def marks(*marks: str, open: bool = False) -> str:
    marks = tuple(m for m in marks if not m.startswith("_"))
    if marks:
        return f"<span foreground=\"red\"> <b>{', '.join(marks)}</b></span>"
    else:
        return ""
    # if "A" <= marks[0] and marks[0] <= "Z":
    #     return chr(0x1f170 + ord(marks[0]) - 0x41)


def truncate(s: str, n: int) -> str:
    if len(s) > n:
        return f'{s[0:n-1]}…'
    else:
        return s


def subscript(i: int) -> str:
    # Could also use <sub> in Pango, but Unicode is more general
    # 0x2050 is ord('₀') - ord('0')
    return "".join(chr(0x2050 + ord(d)) for d in str(i))


def window(win: i3.Con) -> str:
    assert win.type.endswith("con") and not (win.nodes or win.floating_nodes)
    app = win.app_id or win.window_class

    if app == "Firefox-esr":
        icon = ""
    elif app.startswith("foot"):
        icon = ""
    else:
        icon = ""  # "■"

    label = html.escape(truncate(win.name.strip(), 20))

    return f' {icon} {label}{marks(*win.marks)} '


def workspace(ws: i3.Con) -> Iterator[str]:
    assert ws.type == "workspace"
    scratch = ws.name == "__i3_scratch"

    windows = list(chain(ws.leaves(), ws.floating_nodes))

    if (windows and windows[0].focused) or ws.focused:
        yield invert
    if not scratch:
        yield '⟦'
        if not windows:
            yield ' ⋯ '
    for w, cur in enumerate(windows):
        if w:
            if cur.focused:
                yield invert
            prev = windows[w - 1]
            if prev.type == "con" and cur.type == "floating_con":
                yield "┃"
            else:
                yield "┊"
            if prev.focused:
                yield revert
        yield window(cur)
    if not scratch:
        yield '⟧'
    if not scratch:
        yield subscript(ws.num)
    if (windows and windows[-1].focused) or ws.focused:
        yield revert


conn = i3e.Connection("taskbar", auto_reconnect=True)


@conn.handle_event(i3.Event.WINDOW_FOCUS, i3.Event.WINDOW_NEW,
    i3.Event.WINDOW_CLOSE, i3.Event.WINDOW_MARK, i3.Event.WINDOW_TITLE,
    i3.Event.WORKSPACE_FOCUS)
def taskbar(event: i3.Event) -> None:
    tree: i3.Con = conn.get_tree()

    sys.stdout.write(f'<span line_height="{955/1024}">')
    for ws in tree.workspaces():
        for x in workspace(ws):
            sys.stdout.write(x)
        sys.stdout.write("   ")

    scratchpad = tree.scratchpad()
    for w in scratchpad.floating_nodes:
        for x in window(w):
            sys.stdout.write(x)
        sys.stdout.write("  ")

    sys.stdout.write('</span>\n')
    sys.stdout.flush()


if __name__ == "__main__":
    conn.main()
