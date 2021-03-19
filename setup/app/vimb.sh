#!/bin/bash
# vimb - Vim-based browser
set -euo pipefail

sudo apt install webkit2gtk-4.0-dev

git clone https://github.com/fanglingsu/vimb
cd vimb
make
sudo make install
