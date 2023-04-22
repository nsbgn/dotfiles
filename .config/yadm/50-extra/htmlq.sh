#!/bin/bash
# htmlq - Like jq, but for html
#
# SOURCE: https://github.com/mgdm/htmlq
# ALPINE: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/htmlq
# DEBIAN: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1018733
set -euo pipefail

DIR="$HOME/.local/bin"
BIN="htmlq"

if ! which "$BIN" > /dev/null; then
    TMPDIR="$(mktemp -d /tmp/htmlq-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    URL=$(curl -s 'https://api.github.com/repos/mgdm/htmlq/releases/latest' \
        | jq -r '.assets[] | select(.name | endswith("-x86_64-linux.tar.gz")) | .browser_download_url')
    curl -fLo "$TMPDIR/htmlq.tar.gz" "$URL"
    tar -xvf "$TMPDIR/htmlq.tar.gz" -C "$TMPDIR"
    mkdir -p "$DIR"
    cp "$TMPDIR/htmlq" "$DIR/$BIN"
else
    echo "$BIN is already installed." >&2
fi
