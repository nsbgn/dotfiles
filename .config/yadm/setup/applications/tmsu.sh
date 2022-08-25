#!/bin/bash
# tmsu - Tagging files
# https://github.com/oniony/TMSU
set -euo pipefail

mkdir -p ~/.builds/tmsu
wget -O /tmp/tmsu.tgz "$( \
    curl -s 'https://api.github.com/repos/oniony/TMSU/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | select(contains("x86_64")))'\
)"
tar xvf /tmp/tmsu.tgz -C$HOME/.builds
cp ~/.builds/tmsu-*/bin/tmsu ~/.local/bin/tmsu
