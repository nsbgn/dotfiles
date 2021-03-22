#!/bin/bash
# vimb - Vim-based browser
set -euo pipefail

sudo apt install libwebkit2gtk-4.0-dev

rm -rf ~/.builds/vimb ~/.builds/wyebadblock
git clone "https://github.com/fanglingsu/vimb" ~/.builds/vimb
cd ~/.builds/vimb
make
sudo make install
git clone "https://github.com/jun7/wyebadblock" ~/.builds/wyebadblock
cd ~/.builds/wyebadblock
make
sudo make install
sudo ln -s /usr/lib/wyebrowser/adblock.so /usr/local/lib/vimb/
mkdir -p ~/.config/wyebadblock/
wget -O ~/.config/wyebadblock/easylist.txt https://easylist.to/easylist/easylist.txt
