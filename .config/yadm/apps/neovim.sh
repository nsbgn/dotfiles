#!/bin/bash
# Neovim
# Text editor
#
# SOURCE: https://neovim.io/
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/neovim
# DEBIAN: https://packages.debian.org/bullseye/neovim
set -eu

CUR="$(which nvim || echo)"

OLDVER="$(nvim -v | grep "NVIM v" | cut -d' ' -f2)"
NEWVER="$(curl -s 'https://api.github.com/repos/neovim/neovim/releases' | \
    jq -r '[.[] | select(.prerelease == false)] | .[0].tag_name')"

DIR="$HOME/.local/bin"
BIN="nvim"
URL="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"

if [ "$CUR" = "$DIR/$BIN" -a "$OLDVER" = "$NEWVER" ]; then
    echo "Neovim stable ($NEWVER) is installed already." >&2
# elif [ ! -z "$CUR" ]; then
#     echo "You have Neovim $OLDVER installed already (newest is $NEWVER)." >&2
else
    echo "Installing the latest stable Neovim ($NEWVER)." >&2
    mkdir -p "$DIR"
    wget -O "$DIR/$BIN" "$URL"
    chmod +x "$DIR/$BIN"
fi
