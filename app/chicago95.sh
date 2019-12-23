#!/bin/bash
# Chicago95 - A retro Windows 95 theme. I'm just using the icons.
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
