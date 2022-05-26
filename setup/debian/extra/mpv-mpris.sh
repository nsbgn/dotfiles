#!/bin/bash
# mpv-mpris
# MPRIS support for MPV
#
# SOURCE: https://github.com/hoyon/mpv-mpris
# ALPINE: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/mpv-mpris
# DEBIAN: https://packages.debian.org/bookworm/mpv-mpris
set -euo pipefail

URL="$(curl -s 'https://api.github.com/repos/hoyon/mpv-mpris/releases/latest' \
    | jq -r '.assets[] | select(.name == "mpris.so") | .browser_download_url')"
mkdir -p ~/.config/mpv/scripts
curl -fLo ~/.config/mpv/scripts/mpris.so "$URL"
