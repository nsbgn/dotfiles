#!/bin/bash
# bspwm - window manager
set -euo pipefail

sudo apt install libxcb-xinerama0-dev libxcb-keysyms1-dev

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/bspwm"
rm -rf "$INSTALL"
mkdir -p "$INSTALL"

wget -O /tmp/bspwm.tar.gz 'https://github.com/baskerville/bspwm/archive/0.9.10.tar.gz'
tar xvf /tmp/bspwm.tar.gz -C "$INSTALL"
cd "$INSTALL/bspwm-0.9.10"
make
sudo make install

