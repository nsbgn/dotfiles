#!/bin/bash
set -euo pipefail

cd ~/.builds
git clone https://git.sr.ht/~mil/lisgd
cd lisgd
make
sudo make install
