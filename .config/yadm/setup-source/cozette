#!/bin/bash
# Cozette Bitmap fonts, which look better at small resolutions
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

if [ ! -e "$DIR/cozette.otb" ]; then
    TMPDIR="$(mktemp -d /tmp/cozette-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    curl -s 'https://api.github.com/repos/slavfox/cozette/releases/latest' \
    | jq -r '.assets[] | select(.name | endswith(".otb")) | .name + " " + .browser_download_url' \
    | while read NAME URL; do
        curl -fLo "$TMPDIR/$NAME" "$URL"
    done
    sudo mkdir -p "$DIR"
    sudo cp "$TMPDIR/"*.otb "$DIR/"
else
    echo "Cozette is already installed." >&2
fi

# Reload stuff
cd "$DIR"
sudo mkfontdir
sudo mkfontscale
fc-cache -fv
