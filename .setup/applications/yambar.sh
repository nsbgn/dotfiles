#!/bin/bash
# yambar
# Debian: https://packages.debian.org/bookworm/yambar
# Alpine: https://pkgs.alpinelinux.org/package/edge/community/x86_64/yambar

set -e

sudo apt install libyaml-dev

cd ~/.builds
git clone https://codeberg.org/dnkl/yambar
