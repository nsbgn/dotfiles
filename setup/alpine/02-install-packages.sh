#!/bin/sh
# Alpine packages installed on every system
# <https://wiki.alpinelinux.org/wiki/Post_installation>
# <https://wiki.alpinelinux.org/wiki/Alpine_setup_scripts>
# <https://wiki.alpinelinux.org/wiki/How_to_get_regular_stuff_working>
# <https://docs.alpinelinux.org/user-handbook/0.1a/Working/apk.html>
# <https://docs.alpinelinux.org/user-handbook/0.1a/Installing/manual.html>
# <https://wiki.archlinux.org/title/Syslinux#Auto_boot>

# Enable community repositories
tee /etc/apk/repositories << EOF
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/main/
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/community/
https://dl-cdn.alpinelinux.org/alpine/edge/testing/
EOF
apk update
apk upgrade

# Change default shell to bash
# <https://wiki.alpinelinux.org/wiki/Change_default_shell>
apk add libuser ncurses bash bash-completion bash-doc
touch /etc/login.defs
mkdir /etc/default
touch /etc/default/useradd
lchsh $USER

# Microcode
apk add intel-ucode amd-ucode

# Firmware
# cf <https://wiki.alpinelinux.org/wiki/Wi-Fi>
apk install linux-firmware

#  
apk add eudev
setup-udev

apk add seatd
rc-update add seatd
rc-service seatd start
adduser $USER seat

apk add mesa-dri-gallium
addgroup $USER input
addgroup $USER video
addgroup $USER audio

# Enable parallel boot in OpenRC
# <https://unix.stackexchange.com/questions/579013/how-to-improve-startup-time-of-openrc-system>
# <https://wiki.archlinux.org/title/OpenRC>
# <https://wiki.gentoo.org/wiki/OpenRC>
tee -a /etc/rc.conf << EOF
rc_parallel="YES"
EOF

# Fonts
apk add font-raleway-otf font-liberation-sans-narrow font-overpass \
    font-cascadia-code-nerd ttf-anonymous-pro ttf-font-awesome \
    ttf-inconsolata unifont

# Network manager
sudo apk add networkmanager
sudo adduser $USER plugdev
sudo rc-service networkmanager start

# Icons
apk add breeze-icons

# Window managers
apk add river phosh wayfire

# Command not found
apk add command-not-found
update-command-not-found

# Other
apk add keyd  # key remapping
apk add lisgd  # touch gestures
apk add udiskie  # mounted device management
apk add glib  # includes gio trash
apk add network-manager
apk add command-not-found
apk add dbus
apk add playerctl
apk add rsync
apk add curl
apk add wget
apk add rsync
apk add foot # terminal emulator
apk add firefox # web browser
apk add texlive
apk add visurf
apk add xournalpp
apk add telegram-desktop
apk add neovim
apk add git tig delta
apk add fd # find
apk add fzf
apk add aerc
apk add himalaya
apk add mpv mpv-mpris
apk add mupdf
apk add zathura-{cb,djvu,ps,pdf-mupdf,pdf-poppler}
apk add imv
apk add lxappearance
apk add lxpolkit
apk add jq
apk add yj
apk add htmlq
apk add lf
apk add fzf
apk add bat
apk add wget
apk add git
apk add tig
apk add pass
apk add gnupg
apk add lowdown  # Markdown processor
apk add imv  # Image viewer
apk add mustach  # Templating engine
apk add python3
apk add sane-utils  # scanimage
apk add ocrmypdf
apk add nicotine-plus nicotine-plus-doc
apk add bubblewrap  # minimalist firejail
apk add py3-pip
