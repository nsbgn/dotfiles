#!/bin/bash
# Bitmap fonts, which look better at small resolutions
# Of particular interest:
#   - Dina: https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61
#   - Cozette: https://github.com/slavfox/Cozette
set -euo pipefail

# Dina as OpenType font
# wget -O /tmp/dina.tar.gz 'https://www.tartley.com/files/2020/Dina-v2.93-otf.tar.gz'
# tar xvf /tmp/dina.tar.gz /tmp/dina/
# sudo mkdir /usr/share/fonts/dina/
# sudo cp /tmp/dina/* /usr/share/fonts/dina/

DIR="/usr/share/fonts/cozette"
BIN="cozette.otb"

if [ ! -e "$DIR/$BIN" ]; then
    TMPDIR="$(mktemp -d /tmp/cozette-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    URL=$(curl -s 'https://api.github.com/repos/slavfox/cozette/releases/latest' \
        | jq -r '.assets[] | select(.name == "cozette.otb") | .browser_download_url')
    curl -fLo "$TMPDIR/$BIN" "$URL"
    mkdir -p "$DIR"
    sudo cp "$TMPDIR/$BIN" "$DIR/$BIN"
else
    echo "$BIN is already installed." >&2
fi

# Install Cozette
# wget -O /tmp/cozette.otb 'https://github.com/slavfox/Cozette/releases/download/v.1.9.3/cozette.otb'
# sudo mkdir /usr/share/fonts/cozette
# sudo cp /tmp/cozette.otb /usr/share/fonts/cozette/

# Reload stuff
cd "$DIR"
sudo mkfontdir
sudo mkfontscale
fc-cache -fv
