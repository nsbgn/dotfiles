#!/bin/sh
# aerc - An email client
# Debian: https://packages.debian.org/bookworm/aerc
# Alpine: https://pkgs.alpinelinux.org/package/edge/community/x86_64/aerc

BUILD="$HOME/.builds/aerc"
wget -O /tmp/aerc.tar.gz "https://git.sr.ht/~sircmpwn/aerc/archive/fb67d1f5a3f6fe875d74581aff59c79817a7b9f4.tar.gz"
mkdir -p "$BUILD"
tar xvf /tmp/aerc.tar.gz -C"$BUILD"
cd "$BUILD/aerc-*"
sudo apt install dante-client w3m python3 python3-colorama
make
sudo make install
