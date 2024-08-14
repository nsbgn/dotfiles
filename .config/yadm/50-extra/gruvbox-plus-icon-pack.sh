#!/bin/bash
# Icon pack to go with Gruvbox
set -euo pipefail

TMP="$(mktemp)"
TMPD="$(mktemp -d)"
wget -O "${TMP}" "$( \
    curl -fL 'https://api.github.com/repos/SylEleuth/gruvbox-plus-icon-pack/releases/latest' \
    | jq -r '.assets[0].browser_download_url' \
)"
unzip -d "${TMPD}" "${TMP}"
mkdir -p ~/.local/share/icons
cp -rv "${TMPD}"/* ~/.local/share/icons/
rm -r "${TMPD}"
rm "${TMP}"
