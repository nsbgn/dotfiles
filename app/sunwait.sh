#!/bin/bash
# Sunwait - Calculating sunrise or sunset times
set -euo pipefail
IFS=$'\n\t'

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/sunwait"

rm -rf "$INSTALL"
git clone https://github.com/risacher/sunwait "$INSTALL"
cd "$INSTALL"
make all
cp sunwait ~/.local/bin/
