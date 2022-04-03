#!/bin/bash
# lf - File manager
set -euo pipefail

# sudo apt install golang
# go get -u github.com/gokcehan/lf

wget -O /tmp/lf.tar.gz "$( \
    curl -s 'https://api.github.com/repos/gokcehan/lf/releases/latest' \
    | jq -r '.assets | .[] | .browser_download_url | select(endswith("lf-linux-amd64.tar.gz"))'\
)"

mkdir -p ${HOME}/.local/bin
cd ${HOME}/.local/bin && tar xvf /tmp/lf.tar.gz lf
