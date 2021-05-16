#!/bin/bash
# delta - A diff program. See file changes in a readable way
# https://github.com/dandavison/delta
set -euo pipefail

mkdir -p ~/.builds/debs
wget -P ~/.builds/debs/ "$( \
    curl -s 'https://api.github.com/repos/dandavison/delta/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | select(endswith("amd64.deb")))'\
)"
sudo dpkg -i ~/.builds/debs/git-delta*.deb
