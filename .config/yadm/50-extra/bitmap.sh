#!/bin/sh
# Bitmap fonts, which look better at small resolutions. Of particular interest 
# is Dina, which can also be found here:
#   - Original: https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61
#   - As OpenType: https://www.tartley.com/files/2020/Dina-v2.93-otf.tar.gz'
set -eu

DIR="/usr/share/fonts/bitmap"

if [ ! -e "$DIR/" ]; then
    TMPDIR="$(mktemp -d /tmp/bitmap-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    git clone https://github.com/Tecate/bitmap-fonts.git "$TMPDIR"
    sudo cp -avr "$TMPDIR/bitmap" /usr/share/fonts/
else
    echo "$DIR already exists." >&2
fi

# Reload stuff
cd "$DIR"
sudo mkfontdir
sudo mkfontscale
fc-cache -fv
