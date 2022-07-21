# dotfiles

This repository contains my configuration files. The goal is to make them as 
boring as possible while still being useful. Constraints:

-   Prefer small, composable applications that do one thing well.

-   Rely on standard repositories as much as possible, but don't avoid building 
    from source if there is a good reason. Software that is in the repositories 
    [Debian](https://packages.debian.org/) has my preference, especially 
    if it overlaps with [Alpine](https://pkgs.alpinelinux.org/packages) 
    and [Fedora](https://src.fedoraproject.org/).

-   A barebones theme, black on white, using mellow, cozy colours for 
    highlights (such as saffron, brown, terracotta, olive, khaki, rust, 
    charcoal). Easy on the eyes without fancy effects.

Right now, where I deviate from Debian is:

-   `keyd` (Alpine)
-   `lf` (Void, Alpine)
-   `delta` (Void, Alpine)
-   `htmlq` (Alpine)
-   `himalaya` (Void, Alpine)
-   `neovim` (Void, Alpine)
-   `bemenu` (Alpine, 
    [Debian](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=955803)).
-   `river` (Alpine, Debian)

Because the configurations assume that my 
[scripts](https://github.com/slakkenhuis/scripts) are in your `PATH`, these are 
added as a [subtree](https://www.atlassian.com/git/tutorials/git-subtree).

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

-   Compositor: phoc or river. 
    <https://blogs.gnome.org/shell-dev/2022/05/30/towards-gnome-shell-on-mobile/>

