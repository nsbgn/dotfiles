#!/bin/bash
# Reimplementation of Rollercoaster Tycoon 2

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/openrct2"

rm -rf "$INSTALL"
mkdir -p "$INSTALL"

wget -O /tmp/openrct2.tar.gz "$( \ 
    curl -s 'https://api.github.com/repos/OpenRCT2/OpenRCT2/releases/latest' \
    | jq -r '.tarball_url' \
)"
tar xvzf /tmp/openrct2.tar.gz -C "$INSTALL"

sudo apt-get install --no-install-recommends cmake libsdl2-dev libicu-dev \
    gcc pkg-config libjansson-dev libspeex-dev libspeexdsp-dev libcurl4-openssl-dev \
    libcrypto++-dev libfontconfig1-dev libfreetype6-dev libpng-dev libssl-dev libzip-dev \
    build-essential make

cd "$INSTALL/OpenRCT"*
mkdir build
cd build 
cmake ..
make
sudo make install
