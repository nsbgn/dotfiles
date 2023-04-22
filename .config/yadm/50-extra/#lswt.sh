#!/bin/bash
# lswt
set -euo pipefail

cd ${HOME}/.builds/
git clone https://git.sr.ht/~leon_plickat/lswt
cd lswt
make
sudo make install
