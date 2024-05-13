# dotfiles

This repository contains my configuration files, which should be boring 
and few in number. They can be managed using a [bare git 
repository][bare] or with a [dotfile manager][dots] like [yadm][yadm]. 

For the latter, do:

    sudo apt install yadm
    yadm clone https://github.com/nsbgn/dotfiles

My [scripts][scrp] are added as a [subtree][atla] at 
[`.scripts/`](../.scripts).

-   Prefer small, composable applications that do one thing well.

-   Software that impacts my life should be free and open-source.

-   Rely on standard repositories as much as possible, but build from 
    source if there is a good reason. Software that is in the 
    repositories of [Debian][drep] is preferred, especially where it 
    overlaps with [Alpine][arep] and [Fedora][frep].

-   The [`.config/yadm/`](../.config/yadm) directory contains scripts 
    for setting up a new installation. I don't recommend running them 
    as-is: they're mostly there as a reminder to myself.

-   The windowing environments that have my interest are [sway][sway], 
    [Phosh][phsh] and [labwc][labw].


<!-- Footnotes -------------------------------------------------------->

[^1]: Eventually, I want to make the install fully [automatic][auto], or 
    using a [preseed][seed]. Also, make proper packages for 
    [Alpine][apkg] and [Debian][dpkg].

<!-- Links ------------------------------------------------------------>

[atla]: https://www.atlassian.com/git/tutorials/git-subtree
[scrp]: https://github.com/slakkenhuis/scripts
[dots]: https://dotfiles.github.io/utilities/
[yadm]: https://yadm.io/
[bare]: https://cblte.github.io/sammelsurium/configs/the-best-way-to-store-your-dotfiles/
[phsh]: https://wiki.postmarketos.org/wiki/Phosh
[rivr]: https://github.com/riverwm/river
[wayf]: https://wayfire.org/
[sway]: https://swaywm.org/
[labw]: https://labwc.github.io/
[fdec]: https://github.com/AhoyISki/Firedecor
[bspw]: https://github.com/baskerville/bspwm
[tmsu]: https://tmsu.org/
[drep]: https://packages.debian.org/
[arep]: https://pkgs.alpinelinux.org/packages
[frep]: https://src.fedoraproject.org/
[auto]: https://debian-handbook.info/browse/stable/sect.automated-installation.html
[seed]: https://wiki.debian.org/DebianInstaller/Preseed
[apkg]: https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package
[dpkg]: https://wiki.debian.org/Packaging
[eup]: https://www.inkandswitch.com/end-user-programming/
[hea]: https://linuxhandbook.com/check-ssd-health/
