#!/bin/bash
set -euo pipefail

sudo apt install libudev-dev
git clone https://github.com/rvaiya/keyd ~/.builds/keyd
cd ~/.builds/keyd
make
sudo make install
sudo systemctl enable keyd
