#!/bin/sh
# keyd - Keyboard remapper

# SOURCE: https://github.com/rvaiya/keyd
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/keyd
# DEBIAN: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1060023
set -eu

if ! which keyd > /dev/null; then
    mkdir -p ~/.builds
    sudo apt install -y make gcc libudev-dev
    git clone https://github.com/rvaiya/keyd ~/.builds/keyd
    cd ~/.builds/keyd
    make
    sudo make install
    sudo systemctl enable keyd
    sudo systemctl start keyd
fi
