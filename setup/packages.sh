#!/bin/bash
# Installs lots of packages
set -euo pipefail
IFS=$'\n\t'

PACKAGES=(
    # Theme & fonts
    lxappearance # Changing GTK themes
    menulibre # Menu editor
    faenza-icon-theme # Icon theme
    dmz-cursor-theme # White cursor theme
    fonts-dejavu # Standard font
    fonts-inconsolata # Monospace font
    xfonts-terminus # Monospace bitmap font
    fonts-font-awesome # Icon font
    fonts-powerline # Coding fonts
    fonts-nanum # Korean font
    fonts-nanum-coding # Korean monospace font
    fonts-gnutypewriter # Typewriter font

    # Drivers
    xserver-xorg xinit x11-common # X display server
    xserver-xorg-video-{fbdev,intel} # X video drivers
    xserver-xorg-input-{libinput,mouse,kbd,evdev} # X input drivers

    # Printing, scanning, bluetooth
    bluez bluez-tools # Bluetooth support, tools and daemons
    rfkill # Enabling & disabling wireless
    blueman # Bluetooth manager GUI
    btscanner # Bluetooth manager for terminal
    pulseaudio-module-bluetooth # Bluetooth for sound server
    bluez-cups # Bluetooth for printer driver
    cups printer-driver-gutenprint printer-driver-cups-pdf # Print to PDF
    smbclient samba # Print via Samba
    cups-bsd enscript # CLI printing
    system-config-printer gtklp # Printer configuration
    sane-utils # Contains "scanimage" for scanning
    simple-scan # GUI scan utility

    # System utilities & window managers
    #gpp # General purpose preprocessor
    #glyrc # Music metadata finder for CLI
    command-not-found # Suggest packages to install for missing commands
    rxvt-unicode # Terminal emulator
    qemu qemu-kvm virt-manager # Virtualization (like VirtualBox or VMWare)
    git tig # Version control system & ncurses interface
    subversion # Version control system
    #taskwarrior vit # Todo list & ncurses interface
    ledger # Budgetting software. see also hledger and hledger-ui 
    rename # Like `rename 's/S([0-9]*)E([0-9]*) (.*)/$1x$2 $3/g' *.mkv`
    pass # Simple password manager based on gnupg
    lxpolkit # Just a small policykit thing
    #bspwm # Tiling window manager
    i3-wm # Tiling window manager
    #dvtm # Tiling window manager for the terminal
    #byobu # Tiling window manager for the terminal
    screen # Attach and detach from terminal sessions
    tmux # Attach and detach from terminal sessions/tiling for terminal
    x11-utils # X querying utilities (xev, xprop, etc)
    x11-xserver-utils # X server utilities (xrandr, xmodmap, xsetroot, etc)
    x11-xkb-utils # X keyboard utilities (setxkbmap, xkbcomp, etc)
    xinput # Testing and configuring X devices
    xcape # Make modifier keys act as other keys when tapped
    keynav # Allow mouse navigation via keyboard
    xbacklight # Configure screen backlight
    xclip # Command line access to X clipboard
    xsel # Command line access to X clipboard and selection
    sxhkd # Keyboard shortcut daemon
    xdotool # Simulate input & other actions
    unclutter # Hide mouse pointer after inactivity
    redshift # Change screen color at night
    suckless-tools # Tiny single-purpose software, like dmenu (generic menu)
    rover # Terminal update-alternatives frontent
    rofi # Generic menu
    #surf # Small web browser
    i3lock # Screen locker
    dunst # Notification daemon
    alsa-utils # Audio configuration
    pavucontrol # Audio configuration frontend
    arandr # Display configuration frontend
    network-manager ppp network-manager-gnome # Network configuration & frontend
    pinentry-gtk2 # For keyring
    file-roller # Integration of archives into file managers
    scrot # Screenshot application
    xfce4-screenshooter # Screenshot application
    #wakeonlan # See https://wiki.debian.org/WakeOnLan
    ntp # Time daemon to automatically set time
    lm-sensors # Temperature sensors, etc
    htop # System monitor
    net-tools # Contains ifconfig, netstat, route ...
    nethogs # Network monitor 
    pv # Meter data that is passed through UNIX pipeline
    socat # Communicate with sockets
    parallel # Execute commands in parallel
    less # Text pager
    curl # Command line tool to transfer data
    wget # Retrieve files from the web
    wput # Command line FTP client
    lftp # Command line FTP client
    ssh # Remote shell
    jq # Query and manipulate JSON text
    xxd # Hex editor CLI
    w3m # Text internet browser
    elinks # Text internet browser
    rtv # Terminal reddit viewer
    urlview # Selecting urls from email text
    highlight # Universal source code highlighter
    cloc # Count lines of code
    playerctl # Control MPRIS media players
    asciinema # Record terminal sessions
    fd-find # Alternative to the `find` command
    ncdu # See size of direcotries
    tldr # Quickly see how to use a command
    ripgrep # Search directories for a regex pattern
    chafa # Image-to-text converter for terminal
    hexyl # Hex output
    concalc # Command-line calculator
    arbtt # Rule-based time tracker
    pdd # Stopwatch, time diff calculator

    # File & filesystem tools
    util-linux # System utilities like checking filesystem, block devices, etc
    gparted # Partition editor
    rsync # Synchronise files
    secure-delete # Delete files & directories securely, like shred
    cryptsetup # Encrypt filesystems
    gnupg # Encrypt files and emails
    pmount # Mount filesystems as normal user
    fuseiso # Mount ISOs
    sshfs # Mount filesystem via SSH
    fatsort # Sort FAT filesystems (for hardware audio players)
    fdupes # Remove duplicate files
    e2fsprogs exfat-utils dosfstools hfsplus hfsprogs # Filesystem utilities
    ideviceinstaller ifuse # For connecting iPhones, iPods and iPads
    libglib2.0-bin # Includes gio for trashing files from command line
    libimage-exiftool-perl # Inspect EXIF data of media files
    epub-utils # Contains einfo, for inspecting EPUB metadata
    dict dictd dict-gcide dict-freedict-{fra-nld,deu-nld,eng-nld,eng-deu,eng-fra} # Dictionaries + 

    # File conversion tools
    pandoc pandoc-citeproc # Document converter
    hugo # Static site generator
    handbrake # Conversion of multimedia files
    mkvtoolnix-gui # Multiplexing audio/video/subtitles into MKV files
    calibre # Ebook library and conversion suite
    ffmpeg # Conversion of various media formats
    imagemagick # Conversion and batch editing of images
    libvips # Fast conversion and batch editing of images
    paperkey # Dump secret information of gnupg keys for backup
    pdf2djvu # Conversion of PDF to DJVU
    webp # Convert WebP pictures
    ebook2epub # Conversion of various ebook formats to EPUB
    jp2a # Convert JPEG images to ASCII
    wit # Conversion of GameCube and Wii ISOs
    cuetools # Manipulating CUE files from CD rips
    shntool # Manipulating WAV audio files
    qpdf # Manipulating PDF files (decryption, etc)
    minidjvu # Conversion of pages to DJVU
    ocrodjvu # Perform OCR on DJVU documents
    catdoc # Convert Word documents to text
    docx2txt # Convert Word XML documents to text
    python-mutagen # Includes command line MP3 tag editor mid3v2 
    gimagereader # Graphical interface for optical character recognition using tesseract
    ktnef # For opening pesky winmail.dat files in emails
    ytnef-tools # For opening winmail.dat files in emails, via console
    parchive # Archives for data repair
    dtrx atool zip unzip p7zip-full bzip2 rpm unar # Extract/compress archives
    xz-utils xzdec # XZ-format compression and decompression
    python3-breadability # Readability implementation in python

    # Media
    firefox-esr # Web browser. Current version not from repositories
    mpv # Media player
    vlc # Media player
    timidity # Playing MIDI files
    kodi # Media center
    sxiv # Image viewer
    zathura-{pdf-poppler,cb,ps,djvu} # Document reader
    fbreader # Ebook reader
    #ebook-speaker # Ebook speaker

    # Editors
    vim{,-gui-common,-pathogen} # Text editor
    kakoune # Another text editor
    inkscape # Vector graphics
    gimp # Image editor
    #krita # Image editor
    mkvtoolnix{,-gui} # MKV media container editor
    sigil # Ebook editor
    sqlitebrowser # SQLite database editor
    puddletag # Audio tag editor
    #scribus # Document publishing
    #blender # 3D modeller/renderer
    fontforge # Font editor
    subtitleeditor # Subtitle editor
    #meld # Graphical tool to diff & merge files
    gpick # Color picker

    # GUI alternatives
    #synaptic # Package manager
    #gnome-software # Software center
    gnome-packagekit # Package manager, update notifier (see update-notifier)
    software-properties-gtk # Manage repositories
    pcmanfm # File manager
    #claws-mail # Email application
    evince # PDF viewer
    #geany # Generic text editor/IDE
    lxterminal # Terminal emulator
    mirage # Image viewer
    nomacs # Image viewer

    # Messaging
    neomutt # E-mail client
    #notmuch # Email search
    #mailsync # Sync IMAP mails
    #weechat # IRC client
    telegram-desktop # Chat application
    jami # Distributed chat & video client
    #qtox # Distributed chat & video client
    #utox # Distrubted chat & video client

    # Downloading
    httrack # Website downloader
    transmission-{gtk,cli} # BitTorrent client
    nicotine # Soulseek client
    syncthing # Decentralized synchronization of directories between devices

    # Science
    texlive{,-latex-extra,-fonts-extra} # Document typesetting
    libreoffice-{impress,calc,writer,gtk3} # Word processor
    r-base # R statistical analysis software
    gnuplot # Plotting graphics
    #transcriber # Help transcribing speech
    #marble # Map software
    #qmapshack # GPS map manager
    #pspp # Statistical analysis software (SPSS replacement)
    #qgis # Geographic Information System 
    #saga # System for automated geoscientific analysis
    #ossim-core
    #scilab # MATLAB-like numerical analysis software
    #octave # MATLAB-compatible numerical analysis software
    #kalzium # KDE 
    #gperiodic # Periodic table application

    # Emulators
    dolphin-emu # Wii and Gamecube emulator
    mednafen # Multisystem emulator (SNES, GameBoy, Sega, Playstation…)
    mgba-qt # GameBoy (Advance) emulator
    mupen64plus-ui-console cen64 # Nintendo 64 emulators
    pcsxr # PlayStation emulator
    pcsx2:i386 # PlayStation 2 emulator
    desmume # Nintendo DS emulator
    retroarch libretro-bsnes-mercury-balanced libretro-beetle-psx
    libretro-desmume libretro-mgba libretro-mupen64plus libretro-nestopia

    # Games
    0ad # Strategy game
    openmw # Role playing game (reimplementation of Morrowind, no data files)
    minetest # Minecraft clone
    hedgewars # Worms clone
    freeciv # Civ 2 clone
    #flightgear # Flight simulator

    # Laptop-specific applications
    tlp # Laptop power saving (auto)
    powertop # Power saving (manual)
    acpi # Information on acpi devices
    #bumblebee primus bbswitch # Switch discrete graphics card on/off

    # Debian-specific applications
    popularity-contest # Vote for used software
    jigdo-file # Download installation media
    apt-file # Search for package contents

    # Development tools
    build-essential cmake # Assorted build tools
    binutils gcc # Assembler, linker, C compiler
    ghc cabal-install hdevtools # Haskell compiler & tools
    python python3-pip # Python interpreter & package manager
    phantomjs # Headless browser with JavaScript API
    sassc # SASS CSS precompiler
    bison # YACC parser generator

    # Libraries
    python3-bs4 python3-lxml # For the thesaurus script
    dbus-x11 # Contains dbus-launch, which I use for mpris stuff
)

# Install packages
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install "${PACKAGES[@]}"

# Change pinentry from terminal to GTK
sudo update-alternatives --set pinentry /usr/bin/pinentry-gtk-2 

# Turn off services
sudo systemctl disable smbd
sudo systemctl disable apache2
sudo systemctl disable sshd
