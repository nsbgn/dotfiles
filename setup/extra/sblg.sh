#!/bin/bash
# sblg - Static website generation
# https://kristaps.bsd.lv/sblg/
set -euo pipefail

BUILD="$HOME/.builds/sblg"
wget -O /tmp/sblg.tar.gz https://kristaps.bsd.lv/sblg/snapshots/sblg.tar.gz
mkdir -p "$BUILD"
tar xvf /tmp/sblg.tar.gz -C "$BUILD"
cd "$BUILD/sblg*"
./configure
make
sudo make install

