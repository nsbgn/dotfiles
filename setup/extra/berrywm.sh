#!/bin/bash
# berrywm.org - Tiny floating window manager controlled via command line
set -euo pipefail

git clone https://github.com/jlervin/berry ~/.builds/berrywm
cd ~/.builds/berrywm
make
sudo make install
