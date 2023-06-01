#!/bin/bash
# texlab - LSP implementation for LaTeX
#
# SOURCE: https://github.com/latex-lsp/texlab
# ALPINE: https://https://github.com/latex-lsp/texlabpkgs.alpinelinux.org/package/edge/testing/x86_64/texlab
# DEBIAN: -
set -euo pipefail

DIR="$HOME/.local/bin"
BIN="texlab"
if ! which "$BIN" > /dev/null; then
    TMPDIR="$(mktemp -d /tmp/texlab-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    URL="$(curl -s 'https://api.github.com/repos/latex-lsp/texlab/releases/latest' \
        | jq -r '.assets[] | select(.name == "texlab-x86_64-linux.tar.gz") | .browser_download_url')"
    curl -fLo "$TMPDIR/texlab.tar.gz" "$URL"
    tar -xvf "$TMPDIR/texlab.tar.gz" -C "$TMPDIR"
    mkdir -p "$DIR"
    cp "$TMPDIR/texlab" "$DIR/$BIN"
    chmod +x "$DIR/$BIN"
else
    echo "$BIN is already installed." >&2
fi
