#!/bin/sh
set -eu

which keyd || exit 0

cd ~/.builds

if [ -d "thumbledore" ]; then
    cd thumbledore
    git pull
else
    git clone https://github.com/nsbgn/thumbledore.git
    cd thumbledore
fi

sudo make install
sudo systemctl restart keyd
