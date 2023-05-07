#!/bin/bash
# yq - a YAML/XML/CSV etc processor.
# Source: <https://github.com/mikefarah/yq>
# Alpine: <https://pkgs.alpinelinux.org/package/edge/community/x86_64/yq>
# Debian: <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908117>
#
# Annoyingly, Debian's repository has <https://github.com/kislyuk/yq> instead, 
# which is Python-based. See also <https://github.com/sibprogrammer/xq>, which 
# is dedicated to HTML/XML, and <https://github.com/mgdm/htmlq>, which is for 
# HTML. There's also <https://github.com/sclevine/yj>, which converts between 
# YAML and JSON. And finally <https://github.com/tomwright/dasel>.
set -euo pipefail

VERSION=v4.33.3
BINARY=yq_linux_amd64
DIR="${HOME}/.local/bin"
BIN="${DIR}/yq"
if ! which yq; then
    wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O "${BIN}"
    chmod +x "${BIN}"
else
    echo "yq is already installed" >&2
fi
