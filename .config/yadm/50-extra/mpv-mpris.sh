#!/bin/bash
# mpv-mpris
# MPRIS support for MPV. Debian's version is 0.7.1
#
# SOURCE: https://github.com/hoyon/mpv-mpris
# ALPINE: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/mpv-mpris
# DEBIAN: https://packages.debian.org/bookworm/mpv-mpris
set -euo pipefail

DIR="$HOME/.config/mpv/scripts"
BIN="mpris.so"

if [ ! -f "$DIR/$BIN" ]; then
    URL="$(curl -s 'https://api.github.com/repos/hoyon/mpv-mpris/releases/latest' \
        | jq -r '.assets[] | select(.name == "mpris.so") | .browser_download_url')"
    mkdir -p "$DIR"
    curl -fLo "$DIR/$BIN" "$URL"
else
    echo "$BIN is already installed" >&2
fi
