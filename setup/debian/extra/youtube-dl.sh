#!/bin/bash
# youtube-dl
# Streaming video downloader
#
# SOURCE: https://youtube-dl.org/
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/youtube-dl
# DEBIAN: https://packages.debian.org/bullseye/youtube-dl
set -euo pipefail

sudo apt install python3-pip
pip3 install youtube-dl
