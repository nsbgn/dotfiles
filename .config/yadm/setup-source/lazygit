#!/bin/bash
# Source: https://github.com/jesseduffield/lazygit
# Alpine: https://pkgs.alpinelinux.org/package/edge/community/x86_64/lazygit
# Debian: https://github.com/jesseduffield/lazygit/issues/385
set -euo pipefail

TMPDIR="$(mktemp -d /tmp/htmlq-XXX)"
trap "rm -rf $TMPDIR" EXIT

URL="$(curl -s 'https://api.github.com/repos/jesseduffield/lazygit/releases/latest' \
    | jq -r '.assets[]
        | select(.name | endswith("Linux_x86_64.tar.gz"))
        | .browser_download_url')"
curl -fLo "$TMPDIR/lazygit.tar.gz" "$URL"
tar -xvf "$TMPDIR/lazygit.tar.gz" -C "$TMPDIR"
mkdir -p ~/.local/bin
cp "$TMPDIR/lazygit" ~/.local/bin/lazygit
