# dotfiles

This repository contains my configuration files, which should be boring 
and few in number. They can be managed using a [bare git 
repository][bare] or with a [dotfile manager][dots] like [yadm][yadm]. 
Setup scripts are at [`.config/yadm/setup/`](../.config/yadm/setup/). 
Because the configurations assume that my [scripts][scrp] are in your 
`PATH`, these are added as a [subtree][atla] at 
[`.scripts/`](../.scripts).

-   Prefer small, composable applications that do one thing well.

-   Software that is in the repositories of [Debian][debn] is preferred, 
    especially where it overlaps with [Alpine][alpn]. Rely on standard 
    repositories as much as possible, but build from source if there is 
    a good reason.

-   Eventually, I want to make the install fully [automatic][auto], or 
    using a [preseed][seed].

-   The windowing environments that have my interest are [river][rivr], 
    [Phosh][phsh], [Wayfire][wayf] with [Firedecor][fdec], and, in the 
    X11 world, [bspwm][bspw].

[atla]: https://www.atlassian.com/git/tutorials/git-subtree
[scrp]: https://github.com/slakkenhuis/scripts
[dots]: https://dotfiles.github.io/utilities/
[yadm]: https://yadm.io/
[bare]: https://cblte.github.io/sammelsurium/configs/the-best-way-to-store-your-dotfiles/
[debn]: https://packages.debian.org/
[alpn]: https://pkgs.alpinelinux.org/packages
[auto]: https://debian-handbook.info/browse/stable/sect.automated-installation.html
[seed]: https://wiki.debian.org/DebianInstaller/Preseed
[phsh]: https://wiki.postmarketos.org/wiki/Phosh
[rivr]: https://github.com/riverwm/river
[wayf]: https://wayfire.org/
[fdec]: https://github.com/AhoyISki/Firedecor
[bspw]: https://github.com/baskerville/bspwm
