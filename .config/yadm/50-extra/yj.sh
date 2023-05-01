#!/bin/bash
# yj
# Convert between YAML and JSON. Useful for use with `jq`.
#
# SOURCE: https://github.com/sclevine/yj
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/yj
# DEBIAN: -
set -euo pipefail

DIR="$HOME/.local/bin"
BIN="yj"
if ! which "$BIN" > /dev/null; then
    URL="$(curl -s 'https://api.github.com/repos/sclevine/yj/releases/latest' \
        | jq -r '.assets[] | select(.name == "yj-linux-amd64") | .browser_download_url')"
    mkdir -p "$DIR"
    curl -fLo "$DIR/$BIN" "$URL"
    chmod +x "$DIR/$BIN"
else
    echo "$BIN is already installed." >&2
fi
