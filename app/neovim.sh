#!/bin/sh
# Neovim - Text editor
# I need version >= 0.4 for floating windows and better LSP support
# Id rather not use AppImages, but in this case it's easier.

/usr/bin/wget "$( \
    curl -s 'https://api.github.com/repos/neovim/neovim/releases/latest' \
    | jq -r '.assets[] | select(.name=="nvim.appimage") | .browser_download_url' \
)"
chmod +x ~/.local/bin/nvim
