#!/bin/bash
# vim-plug - Vim plugin manager
set -euo pipefail

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
