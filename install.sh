#!/bin/bash

##############################################################################
# Packages

GENERAL=(

    # Drivers
    cups printer-driver-gutenprint # Printing drivers
    linux-firmware # Non-free... Unfortunately needed
    xserver-xorg xinit x11-common # X display server
    #xserver-xorg-video-{fbdev,nouveau,intel,amdgpu} # X video drivers
    xserver-xorg-video-{fbdev,radeon} # X video drivers
    xserver-xorg-input-{synaptics,mouse,kbd,evdev,joystick} # X input drivers
    libgles2-mesa libgl1-mesa-dri

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
    snapd # Alternative package manager
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
    handbrake # Conversion of multimedia files
    mkvtoolnix-gui # Multiplexing audio/video/subtitles into MKV files
    subtitleeditor # Subtitle editor
    cuetools # Manipulating CUE files from CD rips
    shntool # Manipulating WAV audio files
    qpdf # Manipulating PDF files (decryption, etc)
    minidjvu # Conversion of pages to DJVU
    ocrodjvu # Perform OCR on DJVU documents
    cups-pdf # Print to PDF
    odf2txt # Convert Open Document files to text
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
    transmission-{gtk,cli} # BitTorrent client
    nicotine # Soulseek client
    #youtube-dl # Downloading streaming videos and subtitles - is outdated
    httrack # Downloading websites
    mutt # E-mail client
    weechat # IRC client
    ring # Distributed chat & video client
    #qtox # Distributed chat & video client
    #ricochet-im # Distributed chat client

    # Other tools, editors & viewers
    rxvt-unicode # Terminal emulator
    dvtm # Tiling window manager for the terminal
    subversion # Version control system
    git tig # Version control system & ncurses interface
    taskwarrior vit # Todo list & ncurses interface
    #tudu # Also a todo list tracker
    timewarrior # Time tracker
    sqlitebrowser # View SQLite databases
    vim{,-gui-common,-pathogen} # Text editor
    sc # Vim-like spreadsheet editor
    texlive{,-latex-extra,-fonts-extra} # Document typesetting
    libreoffice-{impress,calc,writer,gtk3} # Word processor
    pspp # Statistical analysis software (SPSS replacement)
    scribus # Document publishing
    inkscape # Vector graphics
    kodi # Media center
    gimp # Image editor
    blender # 3D modeller/renderer
    fontforge # Font editor
    mkvtoolnix{,-gui} # MKV media container editor
    sigil # Ebook editor
    #grisbi gnucash # Budgetting software
    puddletag # Audio tag editor
    gnuplot # Plotting graphics
    zathura-{pdf-poppler,cb,ps,djvu} # Document reader
    feh # Image viewer
    sxiv # Image viewer
    fbreader # Ebook reader
    mpv # Media player
    marble # Map software
    qmapshack # GPS map manager
    simple-scan # Scan utility
    scrot # Screenshot application
    xfce4-screenshooter # Screenshot application
    meld # Graphical tool to diff files
    gpick # Color picker
    gparted # Partition editor
    urlview # Selecting urls from email text
    highlight # Universal source code highlighter
    pass # Simple password manager based on gnupg
    paperkey # Dump secret information of gnupg keys for backup
    jq # Query and manipulate JSON text
    asciinema # Record terminal sessions
    dialog # Generic terminal menu application
    whiptail # Generic terminal menu application

    # Matlab-like
    #scilab # MATLAB-like numerical analysis software
    octave # MATLAB-compatible numerical analysis software

    # More user-friendly GUI version of applications
    synaptic # Package manager
    gnome-software # Software center
    gnome-packagekit # Package manager, update notifier (see update-notifier)
    software-properties-gtk # Manage repositories
    vlc # Media player
    timidity # Playing MIDI files
    ristretto # Image viewer
    lxterminal # Terminal emulator
    pcmanfm # File manager
    file-roller # Integration of archives into file managers
    claws-mail # Email application
    geany # Generic text editor/IDE
    evince # PDF viewer
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

# Gaming
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
    golang
    telegram-desktop
    0ad
)


##############################################################################
# Installation script

# Add backports repository
sudo tee -a /etc/apt/sources.list << EOF
deb http://ftp.nl.debian.org/debian/ stretch-backports main non-free contrib
deb-src http://ftp.nl.debian.org/debian/ stretch-backports main non-free contrib
EOF

# Add architecture (needed for PCSX2 emulator)
sudo dpkg --add-architecture i386

#echo "tmpfs /tmp tmpfs rw,nosuid,nodev" | sudo tee -a /etc/fstab

# Update sources
sudo apt update
sudo apt install \
    "${GENERAL[@]}" \
    "${DEVELOPMENT[@]}" \
    "${GAMES[@]}" \
    "${LAPTOP[@]}"
sudo apt search -t stretch-backports \
    "${BACKPORTS[@]}"

# Change pinentry from terminal to GTK
update-alternatives --set pinentry /usr/bin/pinentry-gtk-2 



##############################################################################
# Software from other sources than official repositories

# lf - File manager
go get -u github.com/gokcehan/lf

# youtube-dl - Streaming video downloader
pip3 install youtube-dl

# firefox - Web browser
# The version in the official repositories is ESR, but I want the latest
# version. Could also use snap (sudo apt install snapd; snap install firefox)
# but this way is faster and doesn't put a 'snap' directory in my $HOME…)
wget -O /tmp/firefox.tar.bz2 --content-disposition "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US"
tar xjf /tmp/firefox.tar.bz2 -C/opt

# pandoc - Document converter
wget -O /tmp/pandoc.deb "$(\
    curl -s https://api.github.com/repos/jgm/pandoc/releases/latest \
    | jq -r 'first(.assets[].browser_download_url | select(endswith("amd64.deb")))'\
    )"
sudo dpkg -i /tmp/pandoc.deb

# hugo - Static site generator
wget -O /tmp/hugo.deb "$(\
    curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
    | jq -r 'first(.assets[].browser_download_url | select(endswith("64bit.deb")))'\
    )"
sudo dpkg -i /tmp/hugo.deb

# Dina - Font
wget "https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61"
unzip -d /usr/share/fonts/Dina Dina.zip
cd /usr/share/fonts/Dina/BDF && mkfontscale && mkfontdir; cd -
dpkg-reconfigure fontconfig-config
fc-cache -f

# Applications from github
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
