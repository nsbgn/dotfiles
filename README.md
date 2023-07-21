# ⎅ doublepane

**This is a work-in-progress. The ideas below have not been fully 
implemented.**

This is a set of commands to reduce the mental overhead of using 
[Sway][SWA] and [i3][I3W].

I don't find myself ever benefiting from having more than two windows 
open on the same screen at any one time. (Maybe three, if there's a 
video playing and I pretend to multitask.) So, rather than implementing 
elaborate and abstract ways to automatically *organize* them, I opt for 
a more tangible physical metaphor: stacks of paper. You might hold two 
sheets side-by-side as a reference, but you're only ever writing on one 
at a time.

I then optimize for leafing through these pages. I also minimize the 
amount of keyboard shortcuts or touchscreen gestures that are needed to 
do so.

-   Windows are thrown on a *stack*. Stacks are tiled horizontally if 
    the aspect ratio exceeds 1, and vertically otherwise. By default, 
    the constituent windows are tabbed, but they may also be tiled in 
    the orthogonal direction.

-   Each desktop can show at most two stacks simultaneously. Every stack 
    gets automatically assigned a one-letter label, so that you can 
    instantly bring it to focus or bring another window into focus. In 
    addition to the static labels, there are two dynamic ones for the 
    first and second stack on the current screen.

[SWA]: https://swaywm.org/
[I3W]: https://i3wm.org/
