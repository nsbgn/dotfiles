#!/bin/bash
# Packages installed on every system

PACKAGES=(
    # Theme
    fonts-font-awesome # Font icon
    fonts-cabin # Sans serif font
    fonts-{anonymous-pro,inconsolata,cascadia-code,jetbrains-mono} # Monospace
    fonts-terminus-otb # Bitmap monospace
    dmz-cursor-theme

    # Encryption
    cryptsetup # Block device encryption
    fscrypt # Linux kernel file encryption
    libpam-fscrypt # Auto-unencrypt

    # Sway
    sway
    python3-i3ipc
    swaylock
    wl-clipboard
    wdisplays
    waybar
    yambar

    # Utilities
    aerc # TUI email client
    apt-file # Finding files in Debian packages
    bat # Highlighting
    bemenu # dmenu-like menu for Wayland
    brightnessctl # Controlling the backlight
    bubblewrap # Wrapper for jailing applications
    command-not-found # Suggest packages
    curl # Retrieve files from the web
    direnv # Directory-dependent environment variables
    dtrx # Unzipping various formats
    fd-find # Search for files on the filesystem; `find` alternative
    firefox-esr # Web browser
    git # Version control
    gnupg # Encrypt files and emails
    greetd # Login
    htop # System monitor
    imv # Image viewer
    innoextract # Extract from Windows installers
    jq # Parsing JSON
    khal # TUI calendar
    lf # Directory
    libglib2.0-bin # Trashbin via `gio trash`
    lowdown # Markdown processor and terminal viewer
    lxpolkit # Policy kit
    moreutils # Contains `vipe`, which can edit data between pipes
    mpv # Video viewer
    ncdu # See size of directories
    network-manager # Network
    pandoc pandoc-citeproc # Document converter
    parallel # Execute commands in parallel
    pass # Simple password manager based on gnupg
    playerctl # Controlling MPRIS media players
    pmount # Mount filesystems as normal user
    rename # Use like `rename 's/S([0-9]*)E([0-9]*) (.*)/$1x$2 $3/g' *.mkv`
    rfkill # Enabling & disabling wireless
    ripgrep # Search directories for a regex pattern
    rsync # Synchronizing files
    secure-delete # Delete directories securely, like shred
    telegram-desktop # Chat application
    texlive-{fonts-extra,latex-extra,latex-recommended,science} # LaTeX
    tig # Git TUI frontend
    tmux # Attach and detach from terminal sessions/tiling for terminal
    ufw # Firewall
    util-linux # System utilities like checking filesystem, block devices..
    vdirsyncer # Synchronise CalDAV and CardDAV
    webext-browserpass # `pass` plugin
    webext-ublock-origin-firefox # Ad blocker
    wget # Retrieve files from the web
    xdg-utils # Open in defaul program via `xdg-open`
    xournalpp # Drawing & PDF annotations
    zathura{,-cb,-ps,-djvu,-pdf-poppler} # PDF viewer
)

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y ${PACKAGES[@]}
