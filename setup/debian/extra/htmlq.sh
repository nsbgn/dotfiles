#!/bin/bash
# htmlq
# Like jq, but for html
#
# SOURCE: https://github.com/mgdm/htmlq
# ALPINE: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/htmlq
# DEBIAN: -
set -euo pipefail

TMPDIR="$(mktemp -d /tmp/htmlq-XXX)"
trap "rm -rf $TMPDIR" EXIT
URL=$(curl -s 'https://api.github.com/repos/mgdm/htmlq/releases/latest' \
    | jq -r '.assets[] | select(.name | endswith("-x86_64-linux.tar.gz")) | .browser_download_url')
curl -fLo "$TMPDIR/htmlq.tar.gz" "$URL"
tar -xvf "$TMPDIR/htmlq.tar.gz" -C "$TMPDIR"
mkdir -p ~/.local/bin
cp "$TMPDIR/htmlq" ~/.local/bin/htmlq
