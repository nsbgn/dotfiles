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
# YAML and JSON.

VERSION=v4.33.3
BINARY=yq_linux_amd64
EXE="${HOME}/.local/bin/yq"
wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O ${EXE} &&\
    chmod +x ${EXE}
