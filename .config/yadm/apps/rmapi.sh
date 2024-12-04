#!/bin/sh
# rmapi - Remarkable Cloud API
# https://github.com/juruen/rmapi
set -eu

DIR=$HOME/.local/bin
BIN=rmapi

if ! which "$BIN" > /dev/null; then
    TMPDIR="$(mktemp -d /tmp/rmapi-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    URL="$(curl -s 'https://api.github.com/repos/juruen/rmapi/releases/latest' \
        | jq -r 'first(.assets | .[] | .browser_download_url | select(endswith("linuxx86-64.tar.gz")))'\
    )"
    curl -fLo "$TMPDIR/rmapi.tar.gz" "$URL"
    tar -xvf "$TMPDIR/rmapi.tar.gz" -C "$TMPDIR"
    mkdir -p "$DIR"
    cp "$TMPDIR/rmapi" "$DIR/$BIN"
    chmod +x "$DIR/$BIN"
else
    echo "$BIN is already installed." >&2
fi
