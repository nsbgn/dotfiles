#!/bin/bash
# mpv-mpris - MPRIS support for MPV
set -euo pipefail

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/mpv-mpris"

sudo apt install libmpv-dev libglib2.0-dev
rm -rf "$INSTALL"
git clone https://github.com/hoyon/mpv-mpris "$INSTALL"
cd "$INSTALL"; make install
