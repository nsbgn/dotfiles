#!/bin/bash
# lf
# File manager
#
# SOURCE: https://github.com/gokcehan/lf
# ALPINE: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/lf
# DEBIAN: https://packages.debian.org/bookworm/lf
set -euo pipefail

wget -O /tmp/lf.tar.gz "$( \
    curl -s 'https://api.github.com/repos/gokcehan/lf/releases/latest' \
    | jq -r '.assets | .[] | .browser_download_url | select(endswith("lf-linux-amd64.tar.gz"))'\
)"
mkdir -p ${HOME}/.local/bin
cd ${HOME}/.local/bin && tar xvf /tmp/lf.tar.gz lf
