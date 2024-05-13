#!/bin/bash
# Helix
# Text editor
#
# SOURCE: https://helix-editor.com/
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/helix
# DEBIAN: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1024683
set -eu

CUR="$(which hx || echo)"

OLDVER="$(hx -V | cut -d' ' -f2)"
NEWVER="$(curl -s 'https://api.github.com/repos/helix-editor/helix/releases' | jq -r '.[0].tag_name | sub("(?<y>[0-9]+).0*(?<m>[0-9]+)"; "\(.y).\(.m)")')"

DIR="$HOME/.local/bin"
BIN="hx"

if [ "$CUR" = "$DIR/$BIN" -a "$OLDVER" = "$NEWVER" ]; then
    echo "Helix stable ($NEWVER) is installed already." >&2
elif [ ! -z "$CUR" ]; then
    echo "You have Helix $OLDVER installed already (newest is $NEWVER)." >&2
else
    URL="$(curl -s 'https://api.github.com/repos/helix-editor/helix/releases' | jq -r '.[0].assets[] | select(.name | endswith(".AppImage")) | .browser_download_url')"
    echo "Installing the latest stable Neovim ($NEWVER)." >&2
    mkdir -p "$DIR"
    wget -O "$DIR/$BIN" "$URL"
    chmod +x "$DIR/$BIN"
fi
