#!/bin/bash
# mpv-mpris - MPRIS support for MPV
set -euo pipefail

BUILD="$HOME/.builds/mpv-mpris"
sudo apt install libmpv-dev libglib2.0-dev
git clone "https://github.com/hoyon/mpv-mpris" "$BUILD"
cd "$BUILD"
make
make install
