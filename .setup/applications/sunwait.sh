#!/bin/bash
# sunwait - Calculating sunrise or sunset times
# Alpine: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/sunwait
# Debian: -
set -euo pipefail

BUILD="$HOME/.builds/sunwait"
git clone https://github.com/risacher/sunwait "$BUILD"
cd "$BUILD"
make all
cp sunwait ~/.local/bin/
