#!/bin/bash
# kiwix - Open local encyclopedia

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/kiwix"
wget -O "$INSTALL/kiwix-desktop.appimage" "https://download.kiwix.org/release/kiwix-desktop/kiwix-desktop_x86_64.appimage"
chmod +x "$INSTALL/kiwix-desktop.appimage"
