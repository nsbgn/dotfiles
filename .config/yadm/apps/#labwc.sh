#!/bin/sh
# Stacking Wayland window manager
# Alpine: https://pkgs.alpinelinux.org/package/edge/community/x86_64/labwc
# Debian: https://packages.debian.org/trixie/labwc

ROOT=$HOME/.builds/labwc

sudo apt-get install ninja-build meson

if ! test -d ~/.builds/labwc; then
    cd ~/.builds
    git clone https://github.com/labwc/labwc
fi

cd "$ROOT"
meson build/
ninja -C build/
