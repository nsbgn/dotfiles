#!/bin/sh
# Alpine: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/sc-im
# Debian: https://packages.debian.org/trixie/sc-im
# https://github.com/andmarti1424/sc-im

sudo apt install yacc
cd ~/.builds
git clone https://github.com/andmarti1424/sc-im
cd sc-im
make -C src
sudo make -C src install
