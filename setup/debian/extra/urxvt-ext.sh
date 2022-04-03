#!/bin/bash
# Extensions for urxvt:
# - Dynamic font resizing
# - Scrollback mode
set -euo pipefail

mkdir -p ~/.builds ~/.urxvt/ext
cd ~/.builds
git clone https://github.com/ervandew/urxvt-vim-scrollback
git clone https://github.com/majutsushi/urxvt-font-size
cp urxvt-font-size/font-size urxvt-vim-scrollback/vim-scrollback ~/.urxvt/ext/
