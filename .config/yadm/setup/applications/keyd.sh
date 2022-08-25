#!/bin/bash
# keyd
# Keyboard remapper
#
# SOURCE: https://github.com/rvaiya/keyd
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/keyd
# DEBIAN: -
set -euo pipefail

mkdir -p ~/.builds
sudo apt install libudev-dev
git clone https://github.com/rvaiya/keyd ~/.builds/keyd
cd ~/.builds/keyd
make
sudo make install
sudo systemctl enable keyd
