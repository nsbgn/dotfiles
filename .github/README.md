# dotfiles

This repository contains my configuration files. The goal is to make 
them as boring as possible while still being useful. Constraints:

-   Prefer small, composable applications that do one thing well.

-   Rely on standard repositories as much as possible, but don't avoid 
    building from source if there is a good reason. Software that is in 
    the repositories of [Debian][debn] has my preference, especially if 
    it overlaps with [Alpine][alpn].

-   A barebones theme, black on white, using mellow, cozy colours for 
    highlights (such as saffron, brown, terracotta, olive, khaki, rust, 
    charcoal). Easy on the eyes without fancy effects.

Setup scripts at [`.config/yadm/setup/`](.config/yadm/setup/).

My favourite window managers are river and bspwm. I'm also interested in 
Wayfire with [Firedecor][fdec].

The files can be managed using a [bare git repository][bare] or with 
[yadm](https://yadm.io/), a [dotfile managers][dots] that is in both the 
Debian and Alpine repositories.

Because the configurations assume that my [scripts][scrp] are in your 
`PATH`, these are added as a [subtree][atla]. Eventually, I want to make 
the install fully [automatic][auto], or using a [preseed][seed].

[atla]: https://www.atlassian.com/git/tutorials/git-subtree
[scrp]: https://github.com/slakkenhuis/scripts
[dots]: https://dotfiles.github.io/utilities/
[bare]: https://cblte.github.io/sammelsurium/configs/the-best-way-to-store-your-dotfiles/
[debn]: https://packages.debian.org/
[alpn]: https://pkgs.alpinelinux.org/packages
[fdec]: https://github.com/AhoyISki/Firedecor
[auto]: https://debian-handbook.info/browse/stable/sect.automated-installation.html
[seed]: https://wiki.debian.org/DebianInstaller/Preseed
