#!/bin/bash
# sunwait - Calculating sunrise or sunset times
set -euo pipefail

BUILD="$HOME/.builds/sunwait"
git clone https://github.com/risacher/sunwait "$BUILD"
cd "$BUILD"
make all
cp sunwait ~/.local/bin/
