#!/bin/bash
# kiwix - Open local encyclopedia
set -euo pipefail
IFS=$'\n\t'

/usr/bin/wget -O ~/.local/bin/kiwix-desktop "https://download.kiwix.org/release/kiwix-desktop/kiwix-desktop_x86_64.appimage"
chmod +x ~/.local/bin/kiwix-desktop
