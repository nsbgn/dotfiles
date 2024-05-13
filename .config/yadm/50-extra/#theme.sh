#!/bin/sh
# Theme switcher
# https://github.com/lemnos/theme.sh
set -eu

BIN=$HOME/.local/bin/theme.sh
if [ ! -f "$BIN" ]; then
    curl -Lo "$BIN" 'https://git.io/JM70M' && chmod +x "$BIN"
fi
