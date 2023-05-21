# Editors

Tracking features.

-   <https://neovim.io>
-   <https://lapce.dev/>
-   <https://helix-editor.com/>
-   <https://kakoune.org/>


## Sharing buffers between instances

Native: Kakoune.

For Helix:

-   <https://github.com/helix-editor/helix/issues/312>

For Neovim:

-   <https://github.com/rohit-px2/nvui>
-   <https://github.com/glacambre/nwin>
-   <https://github.com/daa84/neovim-gtk>
-   <https://github.com/Lyude/neovim-gtk>
-   <https://github.com/neovide/neovide>
-   <https://github.com/akiyosi/goneovim>
-   <https://github.com/vhakulinen/gnvim>
-   <https://github.com/beeender/glrnvim>
-   <https://github.com/yatli/fvim>
-   <https://old.reddit.com/r/neovim/comments/b6pnf7/any_way_to_share_the_same_session_between/>
-   <https://old.reddit.com/r/neovim/comments/binsk7/how_close_are_we_to_having_a_single_neovim/>
-   <https://github.com/neovim/neovim/issues/5773>
-   <https://github.com/neovim/neovim/pull/18375>
-   <https://github.com/neovim/neovim/issues/5035>
-   <https://github.com/neovim/neovim/issues/23093>


## Cursor shape to differentiate mode

Native: Neovim, Helix.


## leap-style movement

Neovim has a plugin for this.

Helix:

-   <https://github.com/helix-editor/helix/issues/274>


## Pagination and centering

Zen-mode and kinetic scroll on Neovim helps somewhat with keeping track 
of your position when reading or writing. However, ideally, I would have 
some way of visually indicating pages to *really* know what's happening.

-   Ideal: actual "pages", with grey areas in between. PgUp and PgDn 
    would vertically re-center the page.
-   A vertical ruler next to the page with notches to indicate position, 
    or a horizontal ruler between pages.
-   Simply an alternating background for pages.
