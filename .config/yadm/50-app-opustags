#!/bin/sh
# opustags
# <https://github.com/fmang/opustags>
set -eu

mkdir -p ~/.builds/opustags
cd ~/.builds
git clone https://github.com/fmang/opustags
cd opustags
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=~/.local ..
make
sudo make install
