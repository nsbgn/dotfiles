#!/bin/bash
# Dmenu replacement for Wayland/X11/ncurses
# Alpine: https://pkgs.alpinelinux.org/package/edge/community/x86_64/bemenu
# Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=955803
set -euo pipefail

sudo apt install scdoc wayland-protocols libcairo-dev libpango1.0-dev libxkbcommon-dev libwayland-dev libncurses-dev libcairo2-dev libxinerama-dev
git clone https://github.com/Cloudef/bemenu
cd bemenu
make
sudo make install
ln -s /usr/local/bin/bemenu ~/.local/bin/dmenu
