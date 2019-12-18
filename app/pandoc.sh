#!/bin/bash
# Pandoc. The version in the debian repos is outdated
set -euo pipefail
IFS=$'\n\t'

wget -O /tmp/pandoc.deb "$( \ 
    curl -s 'https://api.github.com/repos/jgm/pandoc/releases/latest' \
    | jq -r '.assets | .[] | .browser_download_url | select(endswith("amd64.deb"))'\
)"

sudo dpkg -i /tmp/pandoc.deb

