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

    # Wayland stuff
    wl-clipboard
    wdisplays

    # System & window manager
    xorg-server # X11
    xinit # X11
    xserver-xorg-video-{intel,fbdev} # Video driver
    xserver-xorg-input-libinput # Input driver
    xserver-xorg-input-xwiimote # Wiimote input driver
    libinput-tools # For detecting tablet mode
    xbacklight # Controlling d
    xinput # List input devices
    unclutter # Hiding mouse
    x11-xkb-utils # Remapping keyboard (xkbcomp)
    xcape # Remapping keyboard (overload tap/hold buttons)
    xcwd # Current directory of program
    x11-xserver-utils # X11 tools (xsetroot)
    hsetroot # for background color (xsetroot with picom)
    picom # compositor
    bspwm
    sxhkd
    dunst
    redshift
    arandr
    lxappearance
    network-manager
    # i3lock
    physlock

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
    jc # parse to json: yaml, xml, output of popular CLI utilities
    fzf
    bat
    wget
    git
    tig
    pass
    gnupg
    fd-find # `find` alternative
    lowdown # Markdown processor
    csv2latex # CSV to LaTeX converter
    csvkit # CSV manipulation on the command line
    python3-jsondiff # JSON diff

    # Applications
    rxvt-unicode
    firefox-esr
    feh
    imv # Image viewer
    mpv
    zathura{,-cb,-ps,-djvu,-pdf-poppler}
    okular{,-extra-backends}
    mupdf
    calcurse # Calendar application
)

sudo apt install ${PACKAGES[@]}
sudo apt install -t bullseye-backports telegram-desktop polybar

sudo apt install kodi kodi-peripheral-joystick kodi-eventclients-wiiremote

sudo update-command-not-found
