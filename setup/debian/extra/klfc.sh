#!/bin/bash
# Create keyboard layout files for xkb
# https://github.com/39aldo39/klfc
set -euo pipefail

mkdir -p ~/.builds/klfc
wget -O ~/.builds/klfc/klfc.tar.xz "$( \
    curl -s 'https://api.github.com/repos/39aldo39/klfc/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url)'\
)"
cd ~/.builds/klfc
#sudo dpkg -i ~/.builds/debs/git-delta*.deb
