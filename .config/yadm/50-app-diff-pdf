#!/bin/bash
# diff-pdf - View differences in pdf
#
# SOURCE: https://github.com/vslavik/diff-pdf
set -euo pipefail

DIR="$HOME/.local/bin"
BIN="diff-pdf"

if ! which "$BIN" > /dev/null; then

    sudo apt-get install libpoppler-glib-dev poppler-utils libwxgtk3.2-dev

    TMPDIR="$(mktemp -d /tmp/diff-pdf-XXX)"
    # trap "rm -rf $TMPDIR" EXIT
    URL=$(curl -s 'https://api.github.com/repos/vslavik/diff-pdf/releases/latest' \
        | jq -r '.assets[] | select(.name | endswith(".tar.gz")) | .browser_download_url')
    curl -fLo "$TMPDIR/diff-pdf.tar.gz" "$URL"
    tar -xvf "$TMPDIR/diff-pdf.tar.gz" -C "$TMPDIR"
    cd "$TMPDIR"/diff-pdf*
    # ./bootstrap
    ./configure
    make
    # make install
    mkdir -p "$DIR"
    cp "$TMPDIR/diff-pdf" "$DIR/$BIN"
else
    echo "$BIN is already installed." >&2
fi
