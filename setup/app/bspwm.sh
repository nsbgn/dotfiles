#!/bin/bash
# bspwm - window manager
# The version in the Debian buster repos is too outdated; I want to set the
# automatic scheme
set -euo pipefail

sudo apt install libxcb-xinerama0-dev libxcb-keysyms1-dev
BUILD="$HOME/.builds/bspwm"
mkdir -p "$BUILD"
wget -O /tmp/bspwm.tar.gz 'https://github.com/baskerville/bspwm/archive/0.9.10.tar.gz'
tar xvf /tmp/bspwm.tar.gz -C "$BUILD"
cd "$BUILD/bspwm-0.9.10"
make
sudo make install

