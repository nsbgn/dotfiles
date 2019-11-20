#!/bin/sh
# Neovim - Text editor
# I need version >= 0.4 for floating windows and better LSP support
# I'd rather not use AppImages, but in this case it's easier.

wget -O ~/.local/bin/nvim "$( \ 
    curl -s 'https://api.github.com/repos/neovim/neovim/releases/latest' \
    | jq -r '.assets[] | select(.name=="nvim.appimage") | .browser_download_url'
)"
chmod +x ~/.local/bin/nvim
