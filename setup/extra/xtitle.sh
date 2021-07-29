#!/bin/bash
set -euo pipefail

git clone https://github.com/baskerville/xtitle ~/.builds/xtitle
cd ~/.builds/xtitle
make
sudo make install
