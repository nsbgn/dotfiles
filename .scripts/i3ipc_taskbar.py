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
# Cf. https://docs.gtk.org/Pango/pango_markup.html

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
import i3ipc_util as i3u
from typing import Iterator

invert = "<span foreground='#000000' background='#ffffff'>"
revert = "</span>"

# Associate emojis with applications
icons = {v: k for k, vs in {
    "◼️": ["foot"],  # other: 🔳🖳🗔⌨️💻🖮 fa: 
    "🌐": ["qutebrowser"],
    "🦊": ["Firefox-esr"],  # fa: 
    "🖨️": ["printer"],
    "🗒️": ["vi", "vim", "neovim"],
    "⚒️": ["something"],
    "🧭": ["mepo"],
    "🗺️": ["QGIS"],
    "🔖": ["sqlitebrowser"],
    "📁": ["lf"],
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
    "*️ ": [None]  # fa: 
}.items() for v in vs}


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


def iconify(app_id: str) -> str:
    try:
        return icons[app_id]
    except KeyError:
        if app_id.startswith("foot-"):
            return icons["foot"]
        else:
            return icons[None]


def window(win: i3.Con) -> str:
    assert win.type.endswith("con") and not (win.nodes or win.floating_nodes)
    app = win.app_id or win.window_class
    name = win.name.strip()
    label = html.escape(truncate(name, 20))
    label = label.replace('~', '<span face="Inconsolata" size="larger">~</span>')
    icon = iconify(app)

    return f' {icon} {label}{marks(*win.marks)} '


def wrap_windows(windows: list[i3.Con],
        before: str = "", mid: str = "", after: str = "",
        empty: str = "") -> Iterator[str]:

    # focused = any(w.focused for w in windows)

    if (windows and windows[0].focused):
        yield invert
    if before:
        yield before
    if not windows:
        yield empty
    else:
        for i, w in enumerate(windows):
            if i:
                if w.focused:
                    yield invert
                w_prev = windows[i - 1]
                yield mid
                if w_prev.focused:
                    yield revert
            yield from window(w)
    if after:
        yield after
    if (windows and windows[-1].focused):
        yield revert


def workspace(tree: i3.Con) -> Iterator[str]:

    ws = i3u.current_workspace(tree)

    assert ws.type == "workspace"
    tiled = ws.leaves()
    before, after = i3u.get_minimized(ws)
    float = ws.floating_nodes

    yield from wrap_windows(before)

    yield from wrap_windows(tiled,
        ' <span size="larger" line_height="0.8">⟨</span> ',
        ' ╱ ',
        ' <span size="larger" line_height="0.8">⟩</span> ',
        ' ⋯ ')

    yield from wrap_windows(after)

    if float:
        yield " ══ "
        yield from wrap_windows(float,
            ' <span size="larger" line_height="0.8">⟦</span> ',
            ' ╱ ',
            ' <span size="larger" line_height="0.8">⟧</span> ')


conn = i3e.Connection("taskbar", auto_reconnect=True)


@conn.handle_event(i3.Event.WINDOW_FOCUS, i3.Event.WINDOW_NEW,
    i3.Event.WINDOW_CLOSE, i3.Event.WINDOW_MARK, i3.Event.WINDOW_TITLE,
    i3.Event.WORKSPACE_FOCUS)
def taskbar(event: i3.Event) -> None:
    tree: i3.Con = conn.get_tree()

    for x in workspace(tree):
        sys.stdout.write(x)

    sys.stdout.write("\n")
    sys.stdout.flush()


if __name__ == "__main__":
    conn.main()
