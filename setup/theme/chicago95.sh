#!/bin/bash
# Chicago95 - A retro Windows 95 theme. I'm using the icons, cursors, the GTK
# theme and the font.
set -euo pipefail
IFS=$'\n\t'

wget -O /tmp/chicago95.zip "$( \
    curl -s 'https://api.github.com/repos/grassmunk/Chicago95/releases/latest' \
    | jq -r '.zipball_url' \
)"
unzip -d /tmp/chicago95 /tmp/chicago95.zip 
mkdir -p ~/.icons ~/.themes
cp -r /tmp/chicago95/grassmunk-Chicago95-*/Theme/* ~/.themes/
cp -r /tmp/chicago95/grassmunk-Chicago95-*/Icons/* ~/.icons/
cp -r /tmp/chicago95/grassmunk-Chicago95-*/Cursors/* ~/.icons/

# See https://github.com/grassmunk/Chicago95/blob/master/INSTALL.md#-ms-sans-serif-font-
if [ -f ../non-free/MSSansSerif.ttf ]; then
    mkdir -p ~/.fonts/truetype/ms_sans_serif/
    cp ../non-free/{micross.ttf,MSSansSerif.ttf} ~/.fonts/truetype/ms_sans_serif/
    mkdir -p ~/.config/fontconfig/conf.d/
    cp /tmp/chicago95/grassmunk-Chicago95-*/Extras/{99-ms-sans-serif.conf,99-ms-sans-serif-bold.conf} ~/.config/fontconfig/conf.d/
    sudo fc-cache -f -v
fi
