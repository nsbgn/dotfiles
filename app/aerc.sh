#!/bin/bash
# aerc - An email client
# Needs golang too
set -euo pipefail
IFS=$'\n\t'

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/aerc"
wget -O /tmp/aerc.tar.gz "https://git.sr.ht/~sircmpwn/aerc/archive/0.2.1.tar.gz"
mkdir -p "$INSTALL"
tar xvf /tmp/aerc.tar.gz -C"$INSTALL"
cd "$INSTALL/aerc-0.2.1"
sudo apt install dante-client w3m python3 python3-colorama
make
sudo make install
