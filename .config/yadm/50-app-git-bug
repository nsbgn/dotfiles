#!/bin/bash
# git-bug - Offline-first git bug tracker with bridges to GitHub et al
#
# SOURCE: https://github.com/MichaelMure/git-bug
# ALPINE: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/git-bug
# DEBIAN: -
set -euo pipefail

DIR="$HOME/.local/bin"
BIN="git-bug"

if [ ! -f "$DIR/$BIN" ]; then
    URL="$(curl -s 'https://api.github.com/repos/MichaelMure/git-bug/releases/latest' \
        | jq -r '.assets[] | select(.name | endswith("_linux_amd64")) | .browser_download_url')"
    mkdir -p "$DIR"
    curl -fLo "$DIR/$BIN" "$URL"
    chmod +x "$DIR/$BIN"
else
    echo "$BIN is already installed" >&2
fi
