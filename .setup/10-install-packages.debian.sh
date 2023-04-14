#!/bin/bash
# Packages installed on every system
set -euo pipefail

PACKAGES=(

    # Theming
    # Sans serif (missing Barlow)
    fonts-{cabin,quicksand,adf-universalis,urw-base35,cantarell,crosextra-caladea,linuxlibertine,inter,go}
    # Serif
    # Monospace (missing Iosevka)
    fonts-{anonymous-pro,hack,go,inconsolata,firacode,liberation,noto,cascadia-code,jetbrains-mono,spleen,terminus,terminus-otb,courier-prime,fantasque-sans}
    # Icon
    fonts-{fork-awesome,font-awesome,material-icons,powerline}
    # Bitmap font
    fonts-unifont

    sway python3-i3ipc

    # numix-{gtk,icon}-theme
    # materia-gtk-theme
    # materia-kde
    # greybird-gtk-theme
    dmz-cursor-theme
    # qt5-gtk{,2}-platform-theme

    libinput-tools # For detecting tablet mode

    fscrypt libpam-fscrypt # Linux kernel file encryption
    gocryptfs # FUSE file encryption
    cryptsetup # Block device encryption

    # Wayland stuff
    wl-clipboard
    wdisplays

    # System & window manager
    # xorg-server # X11
    xinit # X11
    xserver-xorg-video-{intel,fbdev} # Video driver
    xserver-xorg-input-libinput # Input driver
    xserver-xorg-input-xwiimote # Wiimote input driver
    # light # Controlling the backlight
    brightnessctl # Controlling the backlight
    xinput # List input devices
    unclutter # Hiding mouse
    x11-xkb-utils # Remapping keyboard (xkbcomp)
    xcape # Remapping keyboard (overload tap/hold buttons)
    xcwd # Current directory of program
    x11-xserver-utils # X11 tools (xsetroot)
    hsetroot # for background color (xsetroot with picom)
    bspwm
    sxhkd
    dunst
    redshift
    arandr
    lxappearance
    network-manager
    # i3lock
    physlock

    #
    exfatprogs # exFAT support

    # Utilities
    kaddressbook # .vcf address book
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
    apt-file
    rsync
    lxpolkit
    jq
    jc # parse to json: yaml, xml, output of popular CLI utilities
    xdg-utils # xdg-open
    fzf
    bat
    wget
    git
    tig
    meld # diff merge tool
    pass
    gnupg
    fd-find # Search for files on the filesystem; `find` alternative
    lowdown # Markdown processor and terminal viewer
    visidata # CSV data terminal viewer
    csv2latex # CSV to LaTeX converter
    csvkit # CSV manipulation on the command line
    python3-jsondiff # JSON diff
    ufw # firewall
    bubblewrap # wrapper for jailing applications
    mdbtools # Microsoft Access databases

    # Applications
    rxvt-unicode
    firefox-esr
    rssguard
    feh
    imv # Image viewer
    mpv
    zathura{,-cb,-ps,-djvu,-pdf-poppler}
    okular{,-extra-backends}
    mupdf
    khal
    vdirsyncer
    gallery-dl # Download image galleries

    # Python dev environment
    python3-pip
    python3-yaml # dependency for crsync
    python3-future # fixes an issue
    # python3-pyls flake8 pylint python3-autopep8 python3-pycodestyle python3-yapf
)

# Enable backports
sudo tee -a /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian bullseye-backports main contrib non-free
deb-src http://deb.debian.org/debian bullseye-backports main contrib non-free
EOF

sudo apt install ${PACKAGES[@]}
sudo apt install -t bullseye-backports \
    telegram-desktop polybar xournalpp \
    kodi kodi-peripheral-joystick kodi-eventclients-wiiremote

sudo update-command-not-found


#PACKAGES=(
#    # Theme & fonts
#    lxappearance # Changing GTK themes
#    qt5ct # Configure Qt5
#    qt5-gtk{,2}-platformtheme # Qt → GTK theming
#    arc-theme # GTK theme
#    faenza-icon-theme # Icon theme
#    papirus-icon-theme # Icon theme
#    numix-icon-theme{,-circle} # Icon theme
#    dmz-cursor-theme # White cursor theme
#    fonts-dejavu # Standard font
#    fonts-font-awesome # Icon font
#    fonts-material-design-icons-iconfont # Icon font
#    fonts-anonymous-pro # Monospace font I like
#    fonts-powerline # Coding fonts; contains patched Anonymous Pro
#    fonts-nanum # Korean font
#    fonts-nanum-coding # Korean monospace font
#    fonts-adf-ikarius # This font works really well in polybar
#    fonts-adf-*
#    fonts-century-catalogue
#    fonts-agave

#    # Drivers
#    xserver-xorg xinit x11-common # X display server
#    xserver-xorg-video-{fbdev,intel} # X video drivers
#    xserver-xorg-input-{libinput,mouse,kbd,evdev} # X input drivers
#    libvulkan1 mesa-vulkan-drivers vulkan-tools # Vulkan stuff

#    # GUI utils
#    simple-scan # GUI scan utility

#    # Printing, scanning, bluetooth
#    bluez bluez-tools # Bluetooth support, tools and daemons
#    rfkill # Enabling & disabling wireless
#    blueman # Bluetooth manager GUI
#    btscanner # Bluetooth manager for terminal
#    pulseaudio-module-bluetooth # Bluetooth for sound server
#    bluez-cups # Bluetooth for printer driver
#    cups printer-driver-gutenprint printer-driver-cups-pdf # Print to PDF
#    smbclient samba # Print via Samba
#    cups-bsd enscript # CLI printing
#    system-config-printer gtklp # Printer configuration
#    sane-utils # Contains "scanimage" for scanning
#    fasd # Command-line productivity booster

#    # System utilities & window managers
#    #glyrc # Music metadata finder for CLI
#    command-not-found # Suggest packages to install for missing commands
#    rxvt-unicode # Terminal emulator
#    git tig # Version control system & ncurses interface
#    #taskwarrior vit # Todo list & ncurses interface
#    watson # Time management CLI tool
#    ledger # Budgetting software. see also hledger and hledger-ui 
#    rename # Like `rename 's/S([0-9]*)E([0-9]*) (.*)/$1x$2 $3/g' *.mkv`
#    pass # Simple password manager based on gnupg
#    lxpolkit # Just a small policykit thing
#    bspwm # Tiling window manager
#    polybar # Status bar
#    #dvtm # Tiling window manager for the terminal
#    #byobu # Tiling window manager for the terminal
#    #screen # Attach and detach from terminal sessions
#    tmux # Attach and detach from terminal sessions/tiling for terminal
#    x11-utils # X querying utilities (xev, xprop, etc)
#    x11-xserver-utils # X server utilities (xrandr, xmodmap, xsetroot, etc)
#    x11-xkb-utils # X keyboard utilities (setxkbmap, xkbcomp, etc)
#    xinput # Testing and configuring X devices
#    xcape # Make modifier keys act as other keys when tapped
#    keynav # Allow mouse navigation via keyboard
#    xbacklight # Configure screen backlight
#    xclip # Command line access to X clipboard
#    xsel # Command line access to X clipboard and selection
#    sxhkd # Keyboard shortcut daemon
#    xdotool # Simulate input & other actions
#    unclutter # Hide mouse pointer after inactivity
#    redshift # Change screen color at night
#    suckless-tools # Tiny single-purpose software, like dmenu (generic menu)
#    rover # Terminal update-alternatives frontent
#    rofi # Generic menu
#    i3lock # Screen locker
#    dunst # Notification daemon
#    alsa-utils # Audio configuration
#    pavucontrol # Audio configuration frontend
#    arandr # Display configuration frontend
#    network-manager ppp network-manager-gnome # Network configuration & frontend
#    pinentry-gtk2 # For keyring
#    file-roller # Integration of archives into file managers
#    scrot # Screenshot application
#    xfce4-screenshooter # Screenshot application
#    alacarte # Menu editor
#    gtk-vector-screenshot # Vector screenshots of GTK3 applications
#    #wakeonlan # See https://wiki.debian.org/WakeOnLan
#    ntp # Time daemon to automatically set time
#    lm-sensors # Temperature sensors, etc
#    htop # System monitor
#    net-tools # Contains ifconfig, netstat, route ...
#    nethogs # Network monitor
#    pv # Meter data that is passed through UNIX pipeline
#    socat # Communicate with sockets
#    parallel # Execute commands in parallel
#    less # Text pager
#    curl # Command line tool to transfer data
#    wget # Retrieve files from the web
#    wput # Command line FTP client
#    lftp # Command line FTP client
#    ssh # Remote shell
#    jq # Query and manipulate JSON text
#    xxd # Hex editor CLI
#    w3m # Text internet browser
#    elinks # Text internet browser
#    rtv # Terminal reddit viewer
#    urlview # Selecting urls from email text
#    highlight # Universal source code highlighter
#    cloc # Count lines of code
#    playerctl # Control MPRIS media players
#    asciinema # Record terminal sessions
#    fd-find # Alternative to the `find` command
#    ncdu # See size of direcotries
#    tldr # Quickly see how to use a command
#    ripgrep # Search directories for a regex pattern
#    chafa # Image-to-text converter for terminal
#    hexyl # Hex output
#    hexer # Hex editing
#    wuzz # interactive HTTP request inspection tool
#    arbtt # Rule-based time tracker
#    pdd # Stopwatch, time diff calculator

#    # File & filesystem tools
#    util-linux # System utilities like checking filesystem, block devices, etc
#    gparted # Partition editor
#    rsync # Synchronise files
#    secure-delete # Delete files securely, like shred but works on directories
#    cryptsetup # Encrypt filesystems
#    gnupg # Encrypt files and emails
#    pmount # Mount filesystems as normal user
#    fuseiso # Mount ISOs
#    sshfs # Mount filesystem via SSH
#    fatsort # Sort FAT filesystems (for hardware audio players)
#    fdupes # Remove duplicate files
#    findimagedupes # Find image duplicates even if theyve been resized etc
#    e2fsprogs exfat-utils dosfstools hfsplus hfsprogs # Filesystem utilities
#    ideviceinstaller ifuse # For connecting iPhones, iPods and iPads
#    libglib2.0-bin # Includes gio for trashing files from command line
#    libimage-exiftool-perl # Inspect EXIF data of media files
#    epub-utils # Contains einfo, for inspecting EPUB metadata
#    dict dictd dict-gcide dict-freedict-{fra-nld,deu-nld,eng-nld,eng-deu,eng-fra} # Dictionaries + 

#    # File conversion tools
#    pandoc pandoc-citeproc # Document converter
#    unrtf # Convert from RTF to text
#    unoconv # Convert any format supported by libreoffice
#    weasyprint # HTML to PDF printer
#    kiwix # Offline Wikipedia reader
#    hugo # Static site generator
#    handbrake # Conversion of multimedia files
#    mkvtoolnix-gui # Multiplexing audio/video/subtitles into MKV files
#    calibre # Ebook library and conversion suite
#    ffmpeg # Conversion of various media formats
#    imagemagick # Conversion and batch editing of images
#    libvips # Fast conversion and batch editing of images
#    paperkey # Dump secret information of gnupg keys for backup
#    pdf2djvu # Conversion of PDF to DJVU
#    krop # Crop PDFs
#    libtiff-tools # tiff2pdf
#    webp # Convert WebP pictures
#    ebook2epub # Conversion of various ebook formats to EPUB
#    jp2a # Convert JPEG images to ASCII
#    wit # Conversion of GameCube and Wii ISOs
#    cuetools # Manipulating CUE files from CD rips
#    shntool # Manipulating WAV audio files
#    qpdf # Manipulating PDF files (decryption, etc)
#    minidjvu # Conversion of pages to DJVU
#    ocrodjvu # Perform OCR on DJVU documents
#    catdoc # Convert Word documents to text
#    docx2txt # Convert Word XML documents to text
#    python-mutagen # Includes command line MP3 tag editor mid3v2 
#    gimagereader # Graphical interface for optical character recognition using tesseract
#    ktnef # For opening pesky winmail.dat files in emails
#    ytnef-tools # For opening winmail.dat files in emails, via console
#    parchive # Archives for data repair
#    dtrx atool zip unzip p7zip-full bzip2 rpm unar # Extract/compress archives
#    innoextract # Extract from Windows installers
#    xz-utils xzdec # XZ-format compression and decompression
#    python3-breadability # Readability implementation in python
#    bpython3 # Interactive Python interpreter --- helpful!
#    bat # text viewer with syntax highlighting (renamed to batcat)

#    # Media, software suites
#    firefox-esr webext-ublock-origin-firefox # Web browser. Add: uMatrix, Vim Vixen
#    netsurf-gtk # A minimalistic web browser.
#    mpv # Media player
#    gbsplay # Play GB music
#    celluloid # Front-end for mpv
#    vlc # Media player
#    timidity # Playing MIDI files
#    # kodi # Media center
#    sxiv # Image viewer
#    feh # Image viewer
#    pqiv # Image viewer
#    zathura-{pdf-poppler,cb,ps,djvu} # Document reader
#    fbreader # Ebook reader
#    okular{,-extra-backends,-mobile} # Okular, for PDF annotations on touchscreen
#    xournal # Note taking on touchscreen
#    #vim{,-gui-common,-pathogen} # Text editor
#    neovim # Text editor
#    kakoune # Another text editor
#    visidata # Visualiser of spreadsheet data in terminal
#    inkscape # Vector graphics
#    gimp # Image editor
#    drawing # MS Paint clone
#    #krita # Image editor
#    mkvtoolnix{,-gui} # MKV media container editor
#    sigil # Ebook editor
#    sqlitebrowser # SQLite database editor
#    puddletag # Audio tag editor
#    fontforge # Font editor
#    gbdfed # Bitmap font editor
#    subtitleeditor # Subtitle editor
#    imediff # Graphical merge tool for the terminal
#    icdiff # Terminal side-by-side diff
#    dwdiff # Word diff
#    diffpdf # PDF comparison
#    gpick # Color picker
#    grabc # Simple color picker for the terminal
#    kdenlive # Video editing software
#    #synaptic # Package manager
#    #gnome-software # Software center
#    gnome-packagekit # Package manager, update notifier (see update-notifier)
#    software-properties-gtk # Manage repositories
#    pcmanfm # File manager
#    #claws-mail # Email application
#    evince # PDF viewer
#    #geany # Generic text editor/IDE
#    lxterminal # Terminal emulatou
#    mirage # Image viewer
#    scantailor # Book digitization
#    httrack # Website downloader
#    transmission-{gtk,cli} # BitTorrent client
#    nicotine # Soulseek client
#    syncthing # Decentralized synchronization of directories between devices

#    # Communication
#    #notmuch # Email search
#    #mailsync # Sync IMAP mails
#    #weechat # IRC client
#    telegram-desktop # Chat application
#    telegram-cli # Chat application
#    #jami # Distributed chat & video client
#    #qtox # Distributed chat & video client
#    #utox # Distrubted chat & video client
#    #nheko # Distributed chat client for Matrix
#    #spectral # Distributed chat client for Matrix
#    #quaternion # Distributed chat client for Matrix
#    #hexchat # IRC client

#    # Science
#    texlive{,-latex-extra,-fonts-extra,-latex-recommended,-science} # Document typesetting
#    libreoffice-{impress,calc,writer,gtk3} # Word processor
#    r-base # R statistical analysis software
#    gnuplot # Plotting graphics
#    #transcriber # Help transcribing speech
#    #marble # Map software
#    #qmapshack # GPS map manager
#    #pspp # Statistical analysis software (SPSS replacement)
#    #qgis # Geographic Information System 
#    #saga # System for automated geoscientific analysis
#    #ossim-core
#    #scilab # MATLAB-like numerical analysis software
#    #octave # MATLAB-compatible numerical analysis software
#    #kalzium # KDE 
#    #gperiodic # Periodic table application
#    #scribus # Document publishing
#    #blender # 3D modeller/renderer

#    # Emulators & games
#    # dolphin-emu # Wii and Gamecube emulator
#    pcsx2:i386 # PlayStation 2 emulator
#    desmume # Nintendo DS emulator
#    retroarch libretro-bsnes-mercury-balanced libretro-beetle-psx
#    libretro-desmume libretro-mgba libretro-mupen64plus libretro-nestopia
#    0ad # Strategy game
#    openmw # Role playing game (reimplementation of Morrowind, no data files)

#    # Laptop-specific applications
#    tlp # Laptop power saving (auto)
#    powertop # Power saving (manual)
#    acpi # Information on acpi devices
#    #bumblebee primus bbswitch # Switch discrete graphics card on/off

#    # Debian-specific applications
#    popularity-contest # Vote for used software
#    jigdo-file # Download installation media
#    apt-file # Search for package contents

#    # Development tools
#    build-essential cmake # Assorted build tools
#    binutils gcc # Assembler, linker, C compiler
#    ghc cabal-install hdevtools # Haskell compiler & tools
#    python python3-pip # Python interpreter & package manager
#    phantomjs # Headless browser with JavaScript API
#    sassc # SASS CSS precompiler
#    bison # YACC parser generator
#)
