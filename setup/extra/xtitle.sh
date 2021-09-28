#!/bin/bash
set -euo pipefail

sudo apt install libx11-xcb-dev libxcb-{util,ewmh,icccm4}-dev
git clone https://github.com/baskerville/xtitle ~/.builds/xtitle
cd ~/.builds/xtitle
make
sudo make install
