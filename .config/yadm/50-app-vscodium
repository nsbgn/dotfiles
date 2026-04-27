#!/bin/bash
# VSCodium - FOSS version of the Visual Studio Code IDE. I'm still a vim
# fanboy, but VSCode undeniably is easier to work with on touchscreen

# Of course, install Vim extension and add to settings.json:
# "vim.sneak": true,
# "vim.sneakReplacesF": true,
# "vim.easymotion": true,
# "vim.normalModeKeyBindingsNonRecursive": [
#     { "before": [" "]
#     , "after": ["leader", "leader", "leader", "b", "d", "w"]
#     }
# ]

set -euo pipefail

mkdir -p ~/.local/bin
wget -O ~/.local/bin/VSCode "$( \
    curl -s 'https://api.github.com/repos/VSCodium/vscodium/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | select(endswith("x86_64.AppImage")))'\
)"
chmod +x ~/.local/bin/VSCode
