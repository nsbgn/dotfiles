#!/bin/bash
# Neovim
# Text editor
#
# SOURCE: https://neovim.io/
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/neovim
# DEBIAN: https://packages.debian.org/bullseye/neovim
set -euo pipefail

TMPFILE="$(mktemp /tmp/nvim-XXX.deb)"
trap "rm -f $TMPFILE" EXIT
URL="$(curl -s 'https://api.github.com/repos/neovim/neovim/releases/latest' \
    | jq -r '.assets[] | select(.name | endswith("-linux64.deb")) | .browser_download_url')"
curl -fLvo "$TMPFILE" "$URL"
sudo dpkg -i "$TMPFILE"

