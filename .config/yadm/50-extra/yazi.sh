#!/bin/bash
# yazi
# Terminal file manager
#
# SOURCE: https://yazi-rs.github.io/
# ALPINE: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/yazi
# DEBIAN: -
set -euo pipefail

DIR="$HOME/.local/bin/yazi"
BIN="yazi"

if [ ! -f "$DIR/$BIN" ]; then
    URL="$(curl -s 'https://api.github.com/repos/sxyazi/yazi/releases/latest' \
        | jq -r '.assets[] | select(.name == "yazi-x86_64-unknown-linux-gnu.zip") | .browser_download_url')"
    mkdir -p "$DIR"
    curl -fLo "$DIR/$BIN" "$URL"
else
    echo "$BIN is already installed" >&2
fi
