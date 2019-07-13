#!/bin/bash
# polybar - Status bar

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/polybar"

# Install dependencies
sudo apt install \
    build-essential git cmake cmake-data pkg-config i3-wm \
    python3-sphinx python-xcbgen xcb-proto \
    lib{cairo2,xcb1,asound2,pulse,jsoncpp,curl4-openssl,nl-genl-3}-dev \
    libxcb-{util0,randr0,composite0,image0,ewmh,icccm4,xkb,xrm,cursor}-dev 


rm -rf "$INSTALL"
mkdir -p "$INSTALL"

wget -O /tmp/polybar.tar "$( \ 
    curl -s 'https://api.github.com/repos/polybar/polybar/releases/latest' \
    | jq -r 'first(.assets[].browser_download_url) | select(endswith(".tar"))' \
)"
tar xvf /tmp/polybar.tar -C "$INSTALL"

cd "$INSTALL/polybar"
./build.sh
