#!/bin/sh
# Alpine packages installed on every system

PACKAGES=(

    intel-ucode amd-ucode

    # Fonts
    font-raleway-otf
    font-liberation-sans-narrow
    font-overpass
    font-cascadia-code-nerd
    ttf-anonymous-pro
    ttf-font-awesome
    ttf-inconsolata
    unifont

    # Icons
    breeze-icons

    # System
    river  # window manager
    keyd  # key remapping
    lisgd  # touch gestures
    udiskie  # mounted device management
    glib  # incl gio
    network-manager
    command-not-found
    dbus
    playerctl
    rsync
    curl
    wget
    rsync
    foot
    firefox
    texlive
    visurf
    xournalpp
    telegram-desktop
    neovim
    git tig delta
    fd
    fzf
    aerc
    himalaya
    mpv mpv-mpris # mpv
    mupdf
    zathura-{cb,djvu,ps,pdf-mupdf,pdf-poppler}
    imv
    lxappearance
    lxpolkit
    jq
    yj
    htmlq
    lf
    fzf
    bat
    wget
    git
    tig
    pass
    gnupg
    lowdown  # Markdown processor
    imv  # Image viewer
    mustach  # templating engine
    python3
    sane-utils  # scanimage
    ocrmypdf
    nicotine-plus{,doc}
    bubblewrap  # minimalist firejail

    # Utilities
    # dtrx (?)
    # pmount ?(?)
    # jc # parse to json: yaml, xml, output of popular CLI utilities
)

# sudo apk update
# sudo apk upgrade
echo sudo apk add ${PACKAGES[@]}
# sudo update-command-not-found
