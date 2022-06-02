# dotfiles

This repository contains my configuration files. The goal is to make them as 
boring as possible while still being useful. 

The configurations also assume that my 
[scripts](https://github.com/slakkenhuis/scripts) are in your `PATH`, so they 
are added here as a 
[subtree](https://www.atlassian.com/git/tutorials/git-subtree).

My constraints:

-   Prefer small, composable applications that do one thing well.

-   Rely on standard repositories as much as possible, but don't avoid building 
    from source if there is a good reason. Software that is in the repositories 
    of both Alpine and Debian has my preference.

-   A barebones theme, black on white, using mellow, cozy colours for 
    highlights (such as saffron, brown, terracotta, olive, khaki, rust, 
    charcoal). Easy on the eyes without fancy effects.

Right now, where I deviate from Debian is `keyd`, `lf`, `delta`, `htmlq`, 
`himalaya`, `neovim`.

To do:

-   Use [dotfile managers](https://dotfiles.github.io/utilities/). From what I 
    can see, [yadm](https://yadm.io/) and [chezmoi](https://chezmoi.io/) seem 
    most promising, but the former is only in Debian and the latter only in 
    Alpine. [vcsh](https://github.com/RichiH/vcsh) is an option. Alternatively, 
    use a [plain git 
    repository](https://cblte.github.io/sammelsurium/configs/the-best-way-to-store-your-dotfiles/). 
    See also <https://github.com/raven2cz/dotfiles/> for inspiration.
-   There should be a 
    [hook](https://stackoverflow.com/questions/2141492/git-clone-and-post-checkout-hook) 
    that manages all this after cloning.
-   Eventually, I want to make the install fully 
    [automatic](https://debian-handbook.info/browse/stable/sect.automated-installation.html).
