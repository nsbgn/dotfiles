#!/bin/bash
# aerc - An email client

BUILD="$HOME/.builds/aerc"
wget -O /tmp/aerc.tar.gz "https://git.sr.ht/~sircmpwn/aerc/archive/fb67d1f5a3f6fe875d74581aff59c79817a7b9f4.tar.gz"
mkdir -p "$BUILD"
tar xvf /tmp/aerc.tar.gz -C"$BUILD"
cd "$BUILD/aerc-*"
sudo apt install dante-client w3m python3 python3-colorama
make
sudo make install
