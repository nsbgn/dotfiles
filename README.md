# ⎅ twin

**This is a work-in-progress. The ideas below have not been 
implemented.**

`twin` is a set of commands to reduce the mental load of using 
[Sway][SWA] and [i3][I3W].^[Perhaps, eventually, tiling window managers 
and terminal multiplexers in general.]

I don't find myself ever benefiting from having more than two windows 
open at any one time. Maybe three, if there's a video playing and I 
forget that multitasking is a myth. Like a stack of papers, you might 
page through sheets or hold two side-by-side as a reference --- but 
you're only ever writing on one at a time.

With this in mind, `twin` proposes a very number of primitive operations 
that are accessible with a handful of keyboard shortcuts (and/or 
touchscreen gestures).

-   Windows are opened next to or in place of the current focused window 
    (horizontally if the aspect ratio exceeds 1 and vertically 
    otherwise). At any point, there are at most two windows visible 
    (excluding an optional sticky window).
-   Every window gets assigned a one- or two-letter label that doesn't 
    change, so that you can instantly bring it into focus with a 
    keyboard shortcut. Pressing a label key will bring that window into 
    focus. Dual pane mode can be activated by holding shift while 
    focusing on another window, whereas single pane mode is activated by 
    holding shift and focusing on the *current* window.
-   In addition to the static labels, there are three dynamic ones. One 
    refers to the pane on the first half of the screen, one to the pane 
    on the second half, and one to a third pane (probably on a separate 
    monitor or, if none is available, on a dedicated pane).
-   If set, the sticky window is always visible on a separate monitor or 
    a dedicated pane.
-   A window can be assigned a *group*, identified by a common prefix 
    letter. Every window in the same group can be accessed with the 
    one-letter suffix; other windows would need the full label. 
    Visually, every window that's not part of the current group is 
    automatically collapsed in your taskbar (but can be manually 
    expanded).

[SWA]: https://swaywm.org/
[I3W]: https://i3wm.org/
