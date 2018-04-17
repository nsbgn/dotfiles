#!/bin/bash

##############################################################################
# Packages

DRIVERS=(
    cups printer-driver-gutenprint # Printing drivers
    xserver-xorg xinit x11-common # X display server
    xserver-xorg-video-{fbdev,nouveau,intel} # X video drivers
    xserver-xorg-input-{synaptics,mouse,kbd,evdev} # X input drivers
)

THEME=(
    lxappearance # Changing GTK themes
    menulibre # Menu editor
    arc-theme # GTK theme
    faenza-icon-theme # Icon theme
    dmz-cursor-theme # White cursor theme
    fonts-dejavu # Standard font
    fonts-inconsolata # Monospace font
    fonts-font-awesome # Icon font
    fonts-nanum # Korean font
    fonts-nanum-coding # Korean monospace font
)

DESKTOP=(
    bspwm # Tiling window manager
    i3-wm # Tiling window manager
    x11-utils # X querying utilities (xev, xprop, etc)
    x11-xserver-utils # X server utilities (xrandr, xmodmap, xsetroot, etc)
    x11-xkb-utils # X keyboard utilities (setxkbmap, xkbcomp, etc)
    xinput # Testing and configuring X devices
    xcape # Make modifier keys act as other keys when tapped
    xclip # Command line access to X clipboard
    xsel # Command line access to X clipboard and selection
    xdotool # Simulate input & other actions
    sxhkd # Keyboard shortcut daemon
    unclutter # Hide mouse pointer after inactivity
    redshift # Change screen color at night
    xbacklight # Configure screen backlight
    suckless-tools # Tiny single-purpose software, like dmenu (generic menu)
    rofi # Generic menu
    i3lock # Screen locker
    dunst # Notification daemon
    scrot # Screenshot application
    xfce4-screenshooter # Screenshot application
    alsa-utils # Audio configuration
    pavucontrol # Audio configuration frontend
    arandr # Display configuration frontend
    network-manager ppp network-manager-gnome # Network configuration & frontend
)

UTILITIES=(

    # Filesystem
    rsync # Synchronise files
    gnupg # Encrypt files and emails
    cryptsetup # Encrypt filesystems
    pmount # Mount filesystems as normal user
    fuseiso # Mount ISOs
    sshfs # Mount filesystem via SSH
    fatsort # Sort FAT filesystems (for hardware audio players)
    dtrx zip unzip p7zip-full bzip2 rpm unar # Extract/compress archives
    parchive # For data repair
    fdupes # Remove duplicate files

    # File conversion
    ffmpeg # Conversion of various media formats
    imagemagick # Conversion of images
    pdf2djvu # Conversion of PDF to DJVU
    ebook2epub # Conversion of various ebook formats to EPUB
    wit # Conversion of GameCube and Wii ISOs
    cuetools # Manipulating CUE files from CD rips
    shntool # Manipulating WAV audio files
    qpdf # Manipulating PDF files (decryption, etc)
    minidjvu # Conversion of pages to DJVU
    ocrodjvu # Perform OCR on DJVU documents
    cups-pdf # Print to PDF
    pandoc pandoc-citeproc # Convert between many document formats

    # Shell utilities
    ssh # Remote shell
    curl # Command line tool to transfer data
    pv # Meter data that is passed through UNIX pipeline
    jq # Query and manipulate JSON text
    screen # Attach and detach from terminal sessions
    parallel # Execute commands in parallel
    asciinema # Record terminal sessions
    dialog # Generic terminal menu application
    whiptail # Generic terminal menu application

    # Editors
    vim{,-gui-common,-pathogen} # Text editor
    libreoffice-{impress,calc,writer,gtk3} # Word processor
    inkscape # Vector graphics
    gimp # Image editor
    fontforge # Font editor
    puddletag # Audio tag editor
    gnuplot # Plotting graphics

    # Viewers
    firefox # Web browser
    zathura-{pdf-poppler,cb,ps,djvu} # Document reader
    feh # Image viewer
    fbreader # Ebook reader
    mpv # Media player
    marble # Map software
    qmapshack # GPS map manager

    # Communication
    mutt # E-mail client
    telegram-desktop # Chat client
    ring # Distributed chat & video client
    #qtox # Distributed chat & video client
    ricochet-im # Distributed chat client

    # Other 
    rxvt-unicode # Terminal emulator
    htop # System monitor
    nethogs # Network monitor 
    texlive # Document typesetting
    git tig # Version control system & ncurses interface
    taskwarrior vit # Todo list & ncurses interface
    timewarrior # Time tracker
    trash-cli # Command-line interface to trash bin
    pass # Simple password manager based on gnupg
    wget # Retrieve files from the web
    wput # Command line FTP client
    lftp # Command line FTP client
    simple-scan # Scan utility
    gpick # Color picker
    transmission-gtk # BitTorrent client
    youtube-dl # Downloading streaming videos
    httrack # Downloading websites
    w3m # Text internet browser
    elinks # Text internet browser
    phantomjs # Headless browser with JavaScript API
    paperkey # Dump secret information of gnupg keys for backup
    urlview # Selecting urls from email text
)

DEVELOPMENT=(
    binutils gcc # Assembler, linker, C compiler
    ghc # Haskell compiler
    haskell-stack # Haskell ecosystem
    python # Python interpreter
    npm # node.js
    meld # Graphical tool to diff files
)

GAMES=(
    0ad # Strategy game
    nexuiz # Shooter
    #xonotic # Shooter (fork of nexuiz)
    openmw # Role playing game (reimplementation of Morrowind)
    dolphin-emu # Wii and Gamecube emulator
    visualboyadvance-gtk # GameBoy emulator
    mupen64plus # Nintendo 64 emulator
    pcsx2:i386 # Playstation 2 emulator
)

USERFRIENDLY=(
    synaptic # Package manager
    gnome-software # Software center
    gnome-packagekit # Package manager, update notifier (see update-notifier)
    software-properties-gtk # Manage repositories
    vlc # Media player
    ristretto # Image viewer
    lxterminal # Terminal emulator
    pcmanfm # File manager
    claws-mail # Email application
    geany # Generic text editor/IDE
    evince # PDF viewer
)

# Laptop-specific applications
LAPTOP=(
    tlp # Laptop power saving
    bumblebee primus # Switch discrete graphics card on/off
)

# Debian-specific applications
DEBIAN=(
    popularity-contest # Vote for used software
    apt-file # Search for package contents
)

# Libraries that I often need to compile this or other
DEPENDENCIES=(
    libx11-dev
    libxcb-icccm4-dev 
    libxcb-ewmh-dev 
    libxcb-util0-dev 
)

EVERYTHING=(
    "${DRIVERS[@]}"
    "${THEME[@]}"
    "${DESKTOP[@]}"
    "${UTILITIES[@]}"
    "${DEVELOPMENT[@]}"
    "${GAMES[@]}"
    "${LAPTOP[@]}"
    "${USERFRIENDLY[@]}"
    "${DEBIAN[@]}"
    "${DEPENDENDIES[@]}"
)

##############################################################################
# Installation script

# Add architecture (needed for pcsx2)
sudo dpkg --add-architecture i386

# Install packages
sudo apt install "${EVERYTHING[@]}"

# Change pinentry from terminal to GTK
update-alternatives --config pinentry

# Non-packaged applications
mkdir ~/repositories && cd ~/repositories
git clone --recursive https://github.com/jaagr/polybar.git # Status bar
git clone https://github.com/gokcehan/lf.git # File manager
git clone https://github.com/cgag/hostblock.git # Block sites via /etc/hosts
git clone https://github.com/schischi/xcwd.git # Report current directory
git clone https://github.com/ierton/xkb-switch.git # Change keyboard layout via CLI

# Vim plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle && cd ~/.vim/bundle
git clone https://github.com/airblade/vim-gitgutter.git # Show git changes
git clone https://github.com/jamessan/vim-gnupg.git # Open encrypted files
git clone https://github.com/vim-pandoc/vim-pandoc-syntax.git # Highlight markdown
git clone https://github.com/vim-syntastic/syntastic.git # Check code syntax
