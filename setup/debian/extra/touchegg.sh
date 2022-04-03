#!/bin/bash
# Touch gesture recognition
# https://github.com/JoseExposito/touchegg
set -euo pipefail

mkdir -p ~/.builds/debs
wget -P ~/.builds/debs/ "$( \
    curl -s 'https://api.github.com/repos/JoseExposito/touchegg/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | select(endswith("amd64.deb")))'\
)"
sudo dpkg -i ~/.builds/debs/touchegg*.deb
