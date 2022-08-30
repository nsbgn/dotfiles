#!/bin/bash
# delta
# A diff program. View file changes in a readable way.
#
# SOURCE: https://github.com/dandavison/delta
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/delta
# DEBIAN: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=944028
set -euo pipefail

mkdir -p ~/.builds/debs
wget -P ~/.builds/debs/ "$( \
    curl -s 'https://api.github.com/repos/dandavison/delta/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | select(endswith("amd64.deb")))'\
)"
sudo dpkg -i ~/.builds/debs/git-delta*.deb
