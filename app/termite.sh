#!/bin/bash
# Termite - Terminal emulator
set -euo pipefail
IFS=$'\n\t'

TERMITE="${LOCALBUILDS:-$HOME/.local-builds}/termite"
VTE="${LOCALBUILDS:-$HOME/.local-builds}/vte-ng"

sudo apt-get install \
    git \
    g++ \
    libgtk-3-dev \
    gtk-doc-tools \
    gnutls-bin \
    valac \
    intltool \
    libpcre2-dev \
    libglib3.0-cil-dev \
    libgnutls28-dev \
    libgirepository1.0-dev \
    libxml2-utils \
    gperf
    
rm -rf "$TERMITE" "$VTE"
git clone --recursive https://github.com/thestinger/termite.git "$TERMITE"
git clone https://github.com/thestinger/vte-ng.git "$VTE"

echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
cd "$VTE" && ./autogen.sh && make && sudo make install
cd "$TERMITE" && make && sudo make install

sudo ldconfig
sudo mkdir -p /lib/terminfo/x; sudo ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
