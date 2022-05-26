# dotfiles

This repository contains my configuration files. The goal is to make them as 
boring as possible while still being useful. The configurations also assume 
that my [scripts](https://github.com/slakkenhuis/scripts) are in your `PATH`.

My constraints:

-   Prefer small, composable applications that do one thing well.

-   Rely on standard repositories as much as possible, but don't avoid building 
    from source if there is a good reason. Software that is in the repositories 
    of both Alpine and Debian has my preference.

-   A barebones theme, using mellow, cozy colours (such as saffron, brown, 
    terracotta, olive, khaki, rust, charcoal) so as to avoid looking clinical. 
    Easy on the eyes without fancy effects.

Right now, where I deviate from Debian is `keyd`, `lf`, `lisgd`, `aerc`, 
`delta`, `htmlq`, `himalaya`, `neovim`.

To do:

-   Use [dotfile managers](https://dotfiles.github.io/utilities/). From what I 
    can see, [yadm](https://yadm.io/) and [chezmoi](https://chezmoi.io/) seem 
    most promising, but the former is only in Debian and the latter only in 
    Alpine. [vcsh](https://github.com/RichiH/vcsh) is an option. Alternatively, 
    use a [plain git 
    repository](https://cblte.github.io/sammelsurium/configs/the-best-way-to-store-your-dotfiles/). 
-   Add scripts as 
    [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).
-   Eventually, I want to make the install fully 
    [automatic](https://debian-handbook.info/browse/stable/sect.automated-installation.html).
