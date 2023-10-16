# halfwm

This is a set of commands to reduce the mental overhead of using Sway 
and i3.

Window tiling is comfortable, but I don't find myself ever benefiting 
from having more than two windows open on the same screen at any one 
time. Maybe three, if there's a video playing and I pretend to 
multitask. What should be made easier is not the *layout*, but leafing 
through your windows to find the one you need. So, rather than manually 
arranging windows, or implementing elaborate ways to do so 
automatically, let's go for a simpler approach:

-   By default, each window opens in *floating* mode.
-   Every desktop can have between 0 and 2 windows *tiled*. If there's 
    only one tile, its window is maximized; if there's two, there'll be 
    a window on the first half and one on the second half. Tiling is 
    done horizontally if the aspect ratio exceeds 1, and vertically 
    otherwise. They both have a dedicated shortcut. A tiled window that 
    has focus is called *active*; the other one is called the 
    *reference* or *auxiliary*.
-   Any other windows will always be floating on top of the tiled 
    windows, though they may optionally change position based on whether 
    they obscure the active window.
-   Opening back minimized windows should work according to a recency 
    list.
-   One button for each half of the screen. Pressing them both toggles 
    maximization (ie single/dual pane view).
-   Intuitiveness:
    -   The amount of keyboard shortcuts or touchscreen gestures should 
        be small.
    -   All tiling actions must have a logical counterpart in floating 
        mode.
    -   Shortcuts should make just as much sense on stacking window managers 
        (ie. Wayfire/labwc) or terminal multiplexiers (ie. tmux).
    -   Every action must be instantly *reversible* --- if you overshoot, 
        you just go back. This is because feedback is important if you want 
        to move around without consciously thinking about it.

## Actions

### Control

`M-z`
:   Close the current window.

`M-x`
:   Hide (minimize) the current window.

`M-S-x`
:   In floating mode, hide all non-focused floating windows. In tiling 
    mode, hide the auxiliary window.

`M-c`
:   Pull up the most recently minimized window.

`M-v`
:   Maximize the current window.

### Navigation

In general, a bare navigation command switches focus between windows, 
adding `shift` swaps the focused window, and adding `alt` swaps the 
unfocused window(s) in the same layer (where the layer can be either the 
tiling layer or the floating layer).

`M-{j,k}`
:   Focus {first,second} tiled window. If there is only one window, the 
first and second tiled windows are the same.

`M-S-{j,k}`
:   Let us call the {first,second} tiling window `t`, and the current 
    window `f`. In **floating** mode, minimize `t` and put `f` in its 
    place, which puts you in tiling mode. In **tiling** mode, swap `t` 
    and `f`.

`M-{h,l}`
:   In **floating** mode, cycle focus forward through floating windows. 
    In **tiling** mode, move to floating mode.

`M-S-{h,l}`
:   In **tiling** mode, move the current window to the floating layer. 
    In **floating** mode, swap current window with the {previous,next} 
    floating window.

`M-{<,>}`
:   Pull up {previous,next} minimized window into floating layer.

`M-S-{<,>}`
:   In **tiling** mode, swap current window with {previous,next} 
    minimized window. In **floating** mode, minimize current window and 
    pull up {previous,next} minimized window.

`M-A-{<,>}`
:   In **tiling** mode, swap auxiliary window with {previous,next} 
    minimized window. In **floating** mode, minimize all other windows 
    and pull up the {previous,next} minimized window.

`M-{…}`
:   Go to the desktop associated with a specific window, pull it up into 
    the floating layer if it is currently minimized, then focus on it.

`M-S-{…}`
:   Swap current window with a specific window.

`M-A-{…}`
:   Swap auxiliary window with a specific window.
