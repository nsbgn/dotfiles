#!/bin/bash
# f2 - program for batch renaming files
# https://github.com/ayoisaiah/f2
set -euo pipefail

wget -O /tmp/f2.tar.gz "$( \ 
    curl -s 'https://api.github.com/repos/ayoisaiah/f2/releases/latest' \
    | jq -r '.assets | .[] | .browser_download_url | select(endswith("linux_amd64.tar.gz"))'\
)"

cd ${HOME}/.local/bin && tar xvf /tmp/f2.tar.gz f2
