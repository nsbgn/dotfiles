#!/bin/bash

function confirm {
    read -e -p "$@ (y/N) " ANSWER
    case "$ANSWER" in
        [yY][eE][sS]|[yY])
            echo 0
            ;;
        *)
            echo 1
            ;;
    esac
}

##############################################################################
# Packages

DRIVERS=(
    # Drivers
    linux-firmware # Non-free... Unfortunately needed
    xserver-xorg xinit x11-common # X display server
    xserver-xorg-video-{fbdev,intel} # X video drivers
    xserver-xorg-video-{nouveau,radeon,amdgpu} # X video drivers
    xserver-xorg-input-{synaptics,mouse,kbd,evdev} # X input drivers
)

GENERAL=(
    # Printing
    cups printer-driver-gutenprint 
    cups-pdf # Print to PDF

    # Window manager & utilities
    bspwm # Tiling window manager
    i3-wm # Tiling window manager
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
    rofi # Generic menu
    i3lock # Screen locker
    dunst # Notification daemon

    # Theme & fonts
    lxappearance # Changing GTK themes
    menulibre # Menu editor
    arc-theme # GTK theme
    faenza-icon-theme # Icon theme
    dmz-cursor-theme # White cursor theme
    fonts-dejavu # Standard font
    fonts-inconsolata # Monospace font
    xfonts-terminus # Monospace bitmap font
    fonts-font-awesome # Icon font
    fonts-nanum # Korean font
    fonts-nanum-coding # Korean monospace font

    # Debian-specific
    popularity-contest # Vote for used software
    apt-file # Search for package contents

    # System utilities
    #snapd # Alternative package manager
    util-linux # System utilities like checking filesystem, block devices, etc
    ntp # Time daemon to automatically set time
    lm-sensors # Temperature sensors, etc
    htop # System monitor
    nethogs # Network monitor 
    alsa-utils # Audio configuration
    pavucontrol # Audio configuration frontend
    arandr # Display configuration frontend
    network-manager ppp network-manager-gnome # Network configuration & frontend
    pinentry-gtk2 # For keyring
   
    # Shell utilities
    pv # Meter data that is passed through UNIX pipeline
    screen # Attach and detach from terminal sessions
    socat # Communicate with sockets
    parallel # Execute commands in parallel
    less # Text pager

    # File & filesystem tools
    rsync # Synchronise files
    cryptsetup # Encrypt filesystems
    gnupg # Encrypt files and emails
    pmount # Mount filesystems as normal user
    fuseiso # Mount ISOs
    sshfs # Mount filesystem via SSH
    fatsort # Sort FAT filesystems (for hardware audio players)
    dtrx atool zip unzip p7zip-full bzip2 rpm unar # Extract/compress archives
    parchive # For data repair
    fdupes # Remove duplicate files
    e2fsprogs exfat-utils dosfstools hfsplus hfsprogs # Filesystem utilities
    ideviceinstaller ifuse # For connecting iPhones, iPods and iPads
    gvfs-bin # Includes gvfs-trash for trashing files from command line
    libimage-exiftool-perl # Inspect EXIF data of media files
    epub-utils # Contains einfo, for inspecting EPUB metadata
    #mediainfo # Inspect EXIF data of media files

    # File conversion tools
    ffmpeg # Conversion of various media formats
    imagemagick # Conversion of images
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

    # Internet tools
    wget # Retrieve files from the web
    wput # Command line FTP client
    lftp # Command line FTP client
    ssh # Remote shell
    curl # Command line tool to transfer data
    w3m # Text internet browser
    elinks # Text internet browser
    urlview # Selecting urls from email text
    highlight # Universal source code highlighter

    # Other tools, editors & viewers
    rxvt-unicode # Terminal emulator
    dvtm # Tiling window manager for the terminal
    subversion # Version control system
    git tig # Version control system & ncurses interface
    taskwarrior vit # Todo list & ncurses interface
    vim{,-gui-common,-pathogen} # Text editor
    zathura-{pdf-poppler,cb,ps,djvu} # Document reader
    sxiv # Image viewer
    fbreader # Ebook reader
    mpv # Media player
    pass # Simple password manager based on gnupg
    paperkey # Dump secret information of gnupg keys for backup
    jq # Query and manipulate JSON text
    #dialog # Generic terminal menu application
    whiptail # Generic terminal menu application
    asciinema # Record terminal sessions

    pcmanfm # File manager
    vlc # Media player
    file-roller # Integration of archives into file managers
    xfce4-screenshooter # Screenshot application
    simple-scan # Scan utility
)

SUITES=(
    texlive{,-latex-extra,-fonts-extra} # Document typesetting
    libreoffice-{impress,calc,writer,gtk3} # Word processor
    handbrake # Conversion of multimedia files
    mkvtoolnix-gui # Multiplexing audio/video/subtitles into MKV files
    subtitleeditor # Subtitle editor
    httrack # Downloading websites
    transmission-{gtk,cli} # BitTorrent client
    nicotine # Soulseek client
    mutt # E-mail client
    weechat # IRC client
    ring # Distributed chat & video client
    #qtox # Distributed chat & video client
    #ricochet-im # Distributed chat client
    sqlitebrowser # View SQLite databases
    pspp # Statistical analysis software (SPSS replacement)
    scribus # Document publishing
    kodi # Media center
    blender # 3D modeller/renderer
    fontforge # Font editor
    mkvtoolnix{,-gui} # MKV media container editor
    sigil # Ebook editor
    #grisbi gnucash # Budgetting software
    puddletag # Audio tag editor
    inkscape # Vector graphics
    gimp # Image editor
    gnuplot # Plotting graphics
    marble # Map software
    qmapshack # GPS map manager
    scrot # Screenshot application
    meld # Graphical tool to diff files
    gpick # Color picker
    gparted # Partition editor
    scilab # MATLAB-like numerical analysis software
    octave # MATLAB-compatible numerical analysis software
    synaptic # Package manager
    gnome-software # Software center
    gnome-packagekit # Package manager, update notifier (see update-notifier)
    software-properties-gtk # Manage repositories
    timidity # Playing MIDI files
    ristretto # Image viewer
    lxterminal # Terminal emulator
    geany # Generic text editor/IDE
    evince # PDF viewer
    claws-mail # Email application
)

GAMES=(
    # Emulators
    dolphin-emu # Wii and Gamecube emulator
    visualboyadvance-gtk # GameBoy emulator
    mupen64plus # Nintendo 64 emulator
    pcsx2:i386 # Playstation 2 emulator

    # Games
    #0ad # Strategy game
    #xonotic # Shooter (fork of nexuiz)
    #openmw # Role playing game (reimplementation of Morrowind)
)

# Development tools and dependencies
DEVELOPMENT=(
    # Tools
    build-essential # Assorted build tools
    binutils gcc # Assembler, linker, C compiler
    ghc # Haskell compiler
    python # Python interpreter
    phantomjs # Headless browser with JavaScript API
    sassc # SASS CSS precompiler
    bison # YACC parser generator
    "libclang1-6.0"

    # Libraries that I often need to compile this or other
    libx11-dev
    libxcb-icccm4-dev 
    libxcb-ewmh-dev 
    libxcb-util0-dev
    libncursesw5-dev
    libgtk2.0-dev # termite
    libgtk-3-dev # Termite
    gtk-doc-tools # Termite
    intltool # Termite
    libgirepository1.0-dev # Termite
)

# Laptop-specific applications
LAPTOP=(
    tlp # Laptop power saving
    bumblebee primus # Switch discrete graphics card on/off
)

# Things not installed from official repositories due to their version
OUTDATED=(
    firefox # Web browser
    pandoc pandoc-citeproc # Document converter
    haskell-stack # Haskell environment
    golang # Go compiler
    nodejs{,-legacy} # Node.js compiler
)

BACKPORTS=(
    golang # Go compiler
    telegram-desktop # Chat application
)



##############################################################################
# Installation script

if [ "$(confirm "Add backports repository?")" -eq 0 ]; then

# Add backports repository
sudo tee -a /etc/apt/sources.list << EOF
deb http://ftp.nl.debian.org/debian/ stretch-backports main non-free contrib
deb-src http://ftp.nl.debian.org/debian/ stretch-backports main non-free contrib
EOF

fi


#echo "tmpfs /tmp tmpfs rw,nosuid,nodev" | sudo tee -a /etc/fstab


if [ "$(confirm "Install packages?")" -eq 0 ]; then

    PACKAGES=()

    for i in "${GENERAL[@]}"
    do PACKAGES+=("$i" "" 1)
    done

    for i in "${DRIVERS[@]}" "${LAPTOP[@]}" "${DEVELOPMENT[@]}" "${GAMES[@]}" "${SUITES[@]}"
    do PACKAGES+=("$i" "" 0)
    done

    SELECTED_PACKAGES=($(whiptail --separate-output \
        --title "Package selection" --checklist "Select packages." \
        $(stty size) 30 \
        "${PACKAGES[@]}" 3>&1 1>&2 2>&3))

    # Add architecture (needed for PCSX2 emulator)
    sudo dpkg --add-architecture i386

    # Update sources
    sudo apt update
    sudo apt install \
        "${SELECTED_PACKAGES[@]}"
    sudo apt search -t stretch-backports \
        "${BACKPORTS[@]}"

    # Change pinentry from terminal to GTK
    update-alternatives --set pinentry /usr/bin/pinentry-gtk-2 

fi



##############################################################################
# Software from other sources than official repositories

# lf - File manager
if [ "$(confirm "Install lf?")" -eq 0 ]; then
    go get -u github.com/gokcehan/lf
fi

# youtube-dl - Streaming video downloader
if [ "$(confirm "Install youtube-dl?")" -eq 0 ]; then
    pip3 install youtube-dl
fi

# firefox - Web browser
# The version in the official repositories is ESR, but I want the latest
# version. Could also use snap (sudo apt install snapd; snap install firefox)
# but this way is faster and doesn't put a 'snap' directory in my $HOME…)
if [ "$(confirm "Install firefox?")" -eq 0 ]; then
    wget -O /tmp/firefox.tar.bz2 --content-disposition "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
    tar xjf /tmp/firefox.tar.bz2 -C/opt
fi

# pandoc - Document converter
if [ "$(confirm "Install pandoc?")" -eq 0 ]; then
    wget -O /tmp/pandoc.deb "$(\
        curl -s https://api.github.com/repos/jgm/pandoc/releases/latest \
        | jq -r 'first(.assets[].browser_download_url | select(endswith("amd64.deb")))'\
        )"
    sudo dpkg -i /tmp/pandoc.deb
fi

# hugo - Static site generator
if [ "$(confirm "Install hugo?")" -eq 0 ]; then
    wget -O /tmp/hugo.deb "$(\
        curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
        | jq -r 'first(.assets[].browser_download_url | select(endswith("64bit.deb")))'\
        )"
    sudo dpkg -i /tmp/hugo.deb
fi

# Dina - Font
if [ "$(confirm "Install Dina?")" -eq 0 ]; then
    wget "https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61"
    unzip -d /usr/share/fonts/Dina Dina.zip
    cd /usr/share/fonts/Dina/BDF && mkfontscale && mkfontdir; cd -
    dpkg-reconfigure fontconfig-config
    fc-cache -f
fi

# Applications from github
if [ "$(confirm "Copy github repositories?")" -eq 0 ]; then
    mkdir ~/repositories && cd ~/repositories
    git clone --recursive https://github.com/jaagr/polybar.git # Status bar
    git clone https://github.com/schischi/xcwd.git # Report current directory
    #git clone https://github.com/cgag/hostblock.git # Block sites via /etc/hosts
    #git clone https://github.com/andmarti1424/sc-im # Improved spreadsheet editor
    #git clone https://gitlab.com/interception/linux/plugins/caps2esc # Like xcape

    # Install vim plugins
    mkdir -p ~/.vim/autoload ~/.vim/bundle && cd ~/.vim/bundle
    git clone https://github.com/airblade/vim-rooter.git # Sets cwd to project root
    git clone https://github.com/mhinz/vim-signify # Show git or svn changes
    git clone https://github.com/jamessan/vim-gnupg.git # Open encrypted files
    git clone https://github.com/vim-pandoc/vim-pandoc-syntax.git # Highlight markdown
    git clone https://github.com/vim-syntastic/syntastic.git # Check code syntax
    git clone https://github.com/bitc/vim-hdevtools.git # Interactive Haskell development
fi
