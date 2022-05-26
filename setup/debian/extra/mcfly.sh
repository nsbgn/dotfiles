#!/bin/bash
# mcfly
# Shell history search
#
# SOURCE: https://github.com/cantino/mcfly
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/armhf/mcfly
# DEBIAN: -
set -euo pipefail

wget -O /tmp/mcfly.tar.gz "$( \
    curl -s 'https://api.github.com/repos/cantino/mcfly/releases/latest' \
    | jq -r '.assets | .[] | .browser_download_url | select(endswith("x86_64-unknown-linux-gnu.tar.gz"))'\
)"

mkdir -p ${HOME}/.local/bin
cd ${HOME}/.local/bin && tar xvf /tmp/mcfly.tar.gz mcfly
