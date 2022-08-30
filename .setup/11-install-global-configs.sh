#!/bin/sh
# Install all files in $ROOT/.setup/etc/ to /etc/
set -eu

ROOT="$(dirname $0)/.."
ETC="$ROOT/.setup/etc"

find "$ETC" -mindepth 2 -printf '%P\0'  -type f \
| xargs -0 -I{} install -D -m644 "$ETC/{}" "/etc/{}"

# Restart keyd
# sudo systemctl restart keyd
# sleep 1
# xset r rate 300 45
# setxkbmap -option compose:menu
