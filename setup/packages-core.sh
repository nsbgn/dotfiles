#!/bin/bash
# Packages installed on every system
set -euo pipefail

PACKAGES=(

    # Theming
    fonts-{cabin,anonymous-pro,hack,inconsolata,liberation,noto,cascadia-code,unifont,fork-awesome,font-awesome,material-icons}
    # See also: Code New Roman
    numix-{gtk,icon}-theme
    materia-gtk-theme
    materia-kde
    greybird-gtk-theme
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
    xcwd # Current directory of program
    x11-xserver-utils # X11 tools (xsetroot)
    bspwm
    sxhkd
    dunst
    redshift
    arandr
    lxappearance
    network-manager
    i3lock

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
    lemonbar
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
    fd-find # `find` alternative

    # Applications
    rxvt-unicode
    firefox-esr
    feh
    mpv
    zathura{,-cb,-ps,-djvu,-pdf-poppler}
    okular{,-extra-backends}
    mupdf
    calcurse # Calendar application
)

sudo apt install ${PACKAGES[@]}
sudo apt install -t bullseye-backports telegram-desktop polybar

sudo update-command-not-found
