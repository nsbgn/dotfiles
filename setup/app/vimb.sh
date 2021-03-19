#!/bin/bash
# vimb - Vim-based browser
set -euo pipefail

sudo apt install webkit2gtk-4.0-dev

git clone https://github.com/fanglingsu/vimb
cd vimb
make
sudo make install

cd -
git clone https://github.com/jun7/wyebadblock
cd wyebadblock
make
sudo make install
sudo ln -s /usr/lib/wyebrowser/adblock.so /usr/local/lib/vimb/
mkdir -p ~/.config/wyebadblock/
wget -O ~/.config/wyebadblock/easylist.txt https://easylist.to/easylist/easylist.txt
