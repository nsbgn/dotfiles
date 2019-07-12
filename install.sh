#!/bin/bash

LOCALBUILDS="$HOME/.local-builds"
mkdir -p "$LOCALBUILDS"

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

PACKAGES=(
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

    # Drivers
    linux-firmware # Non-free... Needed, unfortunately
    xserver-xorg xinit x11-common # X display server
    xserver-xorg-video-{fbdev,intel} # X video drivers
    xserver-xorg-video-{nouveau,radeon,amdgpu} # X video drivers
    xserver-xorg-input-{libinput,mouse,kbd,evdev} # X input drivers

    # Printing, scanning, bluetooth
    bluetooth 
    bluez 
    bluez-tools 
    rfkill 
    blueman 
    pulseaudio-module-bluetooth 
    bluez-cups
    cups printer-driver-gutenprint printer-driver-cups-pdf # Print to PDF
    smbclient samba # Print via Samba
    system-config-printer gtklp # Printer configuration
    sane-utils # Contains "scanimage" for scanning
    simple-scan # Scan GUI utility

    # System utilities & window managers
    rxvt-unicode # Terminal emulator
    git tig # Version control system & ncurses interface
    subversion # Version control system
    taskwarrior vit # Todo list & ncurses interface
    ledger # Budgetting software. see also hledger and hledger-ui 
    pass # Simple password manager based on gnupg
    bspwm # Tiling window manager
    i3-wm # Tiling window manager
    dvtm # Tiling window manager for the terminal
    byobu # Tiling window manager for the terminal
    screen # Attach and detach from terminal sessions
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
    libnotify-send # Notifications
    alsa-utils # Audio configuration
    pavucontrol # Audio configuration frontend
    arandr # Display configuration frontend
    network-manager ppp network-manager-gnome # Network configuration & frontend
    pinentry-gtk2 # For keyring
    gksu # For admin rights
    file-roller # Integration of archives into file managers
    scrot # Screenshot application
    xfce4-screenshooter # Screenshot application
    wakeonlan # See https://wiki.debian.org/WakeOnLan
    ntp # Time daemon to automatically set time
    lm-sensors # Temperature sensors, etc
    htop # System monitor
    net-tools # Contains ifconfig, netstat, ...
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
    urlview # Selecting urls from email text
    highlight # Universal source code highlighter
    cloc # Count lines of code
    #dialog # Generic terminal menu application
    whiptail # Generic terminal menu application
    playerctl # Control MPRIS media players
    asciinema # Record terminal sessions

    # File & filesystem tools
    util-linux # System utilities like checking filesystem, block devices, etc
    gparted # Partition editor
    rsync # Synchronise files
    secure-delete # Delete files securely, like shred
    cryptsetup # Encrypt filesystems
    gnupg # Encrypt files and emails
    pmount # Mount filesystems as normal user
    fuseiso # Mount ISOs
    sshfs # Mount filesystem via SSH
    fatsort # Sort FAT filesystems (for hardware audio players)
    ms-sys # For Windows master boot record writing
    fdupes # Remove duplicate files
    e2fsprogs exfat-utils dosfstools hfsplus hfsprogs # Filesystem utilities
    ideviceinstaller ifuse # For connecting iPhones, iPods and iPads
    libglib2.0-bin # Includes gio for trashing files from command line
    libimage-exiftool-perl # Inspect EXIF data of media files
    epub-utils # Contains einfo, for inspecting EPUB metadata

    # File conversion tools
    pandoc pandoc-citeproc # Document converter
    hugo # Static site generator
    handbrake # Conversion of multimedia files
    mkvtoolnix-gui # Multiplexing audio/video/subtitles into MKV files
    ffmpeg # Conversion of various media formats
    imagemagick # Conversion of images
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
    gimagereader # Graphical interface for optical character recognition using tesseract
    ktnef # For opening pesky winmail.dat files in emails
    ytnef-tools # For opening winmail.dat files in emails, via console
    parchive # Archives for data repair
    dtrx atool zip unzip p7zip-full bzip2 rpm unar # Extract/compress archives

    # Media
    mpv # Media player
    vlc # Media player
    timidity # Playing MIDI files
    kodi # Media center
    sxiv # Image viewer
    zathura-{pdf-poppler,cb,ps,djvu} # Document reader
    fbreader # Ebook reader

    # Editors
    vim{,-gui-common,-pathogen} # Text editor
    inkscape # Vector graphics
    gimp # Image editor
    krita # Image editor
    mkvtoolnix{,-gui} # MKV media container editor
    sigil # Ebook editor
    sqlitebrowser # SQLite database editor
    puddletag # Audio tag editor
    scribus # Document publishing
    blender # 3D modeller/renderer
    fontforge # Font editor
    subtitleeditor # Subtitle editor
    meld # Graphical tool to diff files
    gpick # Color picker

    # GUI alternatives
    synaptic # Package manager
    gnome-software # Software center
    gnome-packagekit # Package manager, update notifier (see update-notifier)
    software-properties-gtk # Manage repositories
    pcmanfm # File manager
    claws-mail # Email application
    evince # PDF viewer
    geany # Generic text editor/IDE
    ristretto # Image viewer
    lxterminal # Terminal emulator

    # Messaging
    mutt # E-mail client
    weechat # IRC client
    telegram-desktop # Chat application
    ring # Distributed chat & video client
    qtox # Distributed chat & video client
    ricochet-im # Distributed chat client

    # Downloading
    httrack # Website downloader
    transmission-{gtk,cli} # BitTorrent client
    nicotine # Soulseek client

    # Science
    texlive{,-latex-extra,-fonts-extra} # Document typesetting
    libreoffice-{impress,calc,writer,gtk3} # Word processor
    marble # Map software
    qmapshack # GPS map manager
    r-base # R statistical analysis software
    pspp # Statistical analysis software (SPSS replacement)
    gnuplot # Plotting graphics
    saga # System for automated geoscientific analysis
    scilab # MATLAB-like numerical analysis software
    octave # MATLAB-compatible numerical analysis software

    # Emulators
    dolphin-emu # Wii and Gamecube emulator
    visualboyadvance-gtk # GameBoy emulator
    mupen64plus # Nintendo 64 emulator
    pcsx2:i386 # Playstation 2 emulator

    # Games
    0ad # Strategy game
    openmw # Role playing game (reimplementation of Morrowind)
    minetest # Minecraft clone

    # Laptop-specific applications
    tlp # Laptop power saving
    #bumblebee primus # Switch discrete graphics card on/off

    # Debian-specific applications
    popularity-contest # Vote for used software
    apt-file # Search for package contents

    # Development tools
    build-essential # Assorted build tools
    binutils gcc # Assembler, linker, C compiler
    ghc cabal-install hdevtools # Haskell compiler & tools
    rustc cargo # Rust compiler & tools
    golang # Go compiler
    nodejs{,-legacy} npm # Node.js compiler & package manager
    python python-pip3 # Python interpreter & package manager
    phantomjs # Headless browser with JavaScript API
    sassc # SASS CSS precompiler
    bison # YACC parser generator

    # Libraries that I often need to compile this or other
    libx11-dev
    libxcb-icccm4-dev 
    libxcb-ewmh-dev 
    libxcb-util0-dev
    libncursesw5-dev
    libgtk2.0-dev # termite
    libgtk-3-dev # Termite
    libpcre2-dev
    gnutls-bin libgnutls28-dev # Termite
    gperf # Termite
    gtk-doc-tools # Termite
    intltool # Termite
    libgirepository1.0-dev # Termite
    python3-bs4 # thesaurus
    python3-lxml # thesaurus
    "libclang1-6.0"
    libmpv-dev # Music player dev files, for mpris.so
)


if [ "$(confirm "Install packages?")" -eq 0 ]; then

    sudo apt update
    sudo apt install whiptail

    PACKAGES2=()
    for i in "${PACKAGES[@]}"; do 
        PACKAGES2+=("$i" "" 1)
    done

    SELECTED_PACKAGES=($(whiptail --separate-output \
        --title "Package selection" --checklist "Select packages." \
        $(stty size) 30 \
        "${PACKAGES2[@]}" 3>&1 1>&2 2>&3))

    # Add architecture (needed for PCSX2 emulator)
    sudo dpkg --add-architecture i386

    # Update sources
    sudo apt update
    sudo apt install "${SELECTED_PACKAGES[@]}"
fi

if [ "$(confirm "Configure?")" -eq 0 ]; then

    # Change pinentry from terminal to GTK
    sudo update-alternatives --set pinentry /usr/bin/pinentry-gtk-2 

    # Turn off services
    sudo systemctl disable smbd
    sudo systemctl disable apache2

    # Make /tmp a tmpfs
    if [ grep -q '^tmpfs\s\+/tmp\s' /etc/fstab ]; then
        echo "tmpfs /tmp tmpfs rw,nosuid,nodev" | sudo tee -a /etc/fstab
    fi
fi

###############################################################################
# Software from other sources than official repositories

# firefox - Web browser (one in official repositories is ESR)
if [ "$(confirm "Install firefox?")" -eq 0 ]; then
    wget -O /tmp/firefox.tar.bz2 --content-disposition "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
    sudo tar xjf /tmp/firefox.tar.bz2 -C/opt
fi

# lf - File manager
if [ "$(confirm "Install lf?")" -eq 0 ]; then
    go get -u github.com/gokcehan/lf
fi

# youtube-dl - Streaming video downloader
if [ "$(confirm "Install youtube-dl?")" -eq 0 ]; then
    pip3 install youtube-dl
fi

# Fx - JSON viewer
if [ "$(confirm "Install fx?")" -eq 0 ]; then
    npm install -g fx
fi

# Dina - Font
if [ "$(confirm "Install Dina?")" -eq 0 ]; then
    wget -O Dina.zip "https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61"
    sudo unzip -d /usr/share/fonts/Dina Dina.zip
    cd /usr/share/fonts/Dina/BDF && sudo mkfontscale && sudo mkfontdir
    sudo dpkg-reconfigure fontconfig-config
    fc-cache -f
    cd -
fi

# mpv-mpris - MPRIS support for MPV
if [ "$(confirm "Install mpv-mpris?")" -eq 0 ]; then
    git clone https://github.com/hoyon/mpv-mpris "$LOCALBUILDS/mpv-mpris"
    cd "$LOCALBUILDS/mpv-mpris"
    make install
    cd -
fi

# hostblock - Blocking via /etc/hosts
if [ "$(confirm "Install hostblock?")" -eq 0 ]; then
    git clone https://github.com/cgag/hostblock.git "$LOCALBUILDS/hostblock"
    cd "$LOCALBUILDS/hostblock"
    cargo build --release && sudo cp target/release/hostblock /usr/sbin/
    cd -
fi

# polybar - Status bar
if [ "$(confirm "Install polybar?")" -eq 0 ]; then
    URL="$( \ 
    curl -s 'https://api.github.com/repos/polybar/polybar/releases/latest' \
    | jq -r 'first(.assets[].browser_download_url) | select(endswith(".tar"))' \
    )"
    DIR1="$PWD"
    DIR2="$LOCALBUILDS/polybar"

    wget -O /tmp/polybar.tar "$URL"
    mkdir -p "$DIR2"; cd "$DIR2"; tar xvf /tmp/polybar.tar
    cd "$DIR2/polybar"; ./build.sh
    cd "$DIR1"
fi

# vim plugins
if [ "$(confirm "Install vim plugins?")" -eq 0 ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && cd ~/.vim/bundle
    git clone https://github.com/airblade/vim-rooter.git # Sets cwd to project root
    git clone https://github.com/jamessan/vim-gnupg.git # Open encrypted files
    git clone https://github.com/vim-syntastic/syntastic.git # Check code syntax
    git clone https://github.com/bitc/vim-hdevtools.git # Interactive Haskell development
    git clone https://github.com/vim-pandoc/vim-pandoc-syntax.git # Highlight markdown
    git clone https://github.com/ledger/vim-ledger.git # ledger/hledger journal writing
    git clone https://github.com/mhinz/vim-signify # Show git or svn changes
    git clone https://github.com/tpope/vim-fugitive.git # Git wrapper to see blame etc
    git clone git://repo.or.cz/vcscommand.git # VCS wrapper to see blame
    cd -
fi

# Other interesting software
#https://gitlab.com/interception/linux/plugins/caps2esc # Like xcape
#https://github.com/TES3MP/openmw-tes3mp/wiki/Running-TES3MP-server-on-an-Raspberry-PI
#https://dl.xonotic.org/xonotic-0.8.2.zip # Shooter
#https://git.suckless.org/quark # static website hosting
#https://git.sr.ht/~sircmpwn/aerc2 # email client
