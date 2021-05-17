#!/bin/bash
# Packages installed on every system
set -euo pipefail

PACKAGES=(

    # Theming
    fonts-{cabin,anonymous-pro,unifont}
    numix-{gtk,icon}-theme
    dmz-cursor-theme
    qt5-gtk{,2}-platform-theme

    # System & window manager
    xorg-server # X11
    xinit # X11
    xserver-xorg-video-{intel,fbdev} # Video driver
    xserver-xorg-input-libinput # Input driver
    libinput-tools # For detecting tablet mode
    xbacklight # Controlling display backlight
    xinput # List input devices
    unclutter # Hiding mouse
    x11-xkb-utils # Remapping keyboard (xkbcomp)
    xcape # Remapping keyboard (overload tap/hold buttons)
    x11-xserver-utils # X11 tools (xsetroot)
    bspwm
    sxhkd
    dunst
    redshift
    arandr
    lxappearance
    network-manager

    # Utilities
    xdotool
    libglib2.0-bin # trashbin (gio)
    command-not-found
    dtrx
    unzip
    dbus-x11
    curl
    playerctl
    rofi
    polybar
    pmount
    neovim
    apt-file
    rsync
    lxpolkit
    jq
    fzf
    bat
    wget
    git
    tig
    pass
    gnupg
    uuidgen-runtime  # for uuidgen

    # Applications
    rxvt-unicode
    firefox-esr
    feh
    mpv
    onboard
    zathura{,-cb,-ps,-djvu,-pdf-poppler}
    okular{,-extra-backends}
    mupdf
)

sudo apt install ${PACKAGES[@]}

sudo update-command-not-found
