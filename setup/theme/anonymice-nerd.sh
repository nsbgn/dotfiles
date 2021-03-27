#!/bin/bash
set -euo pipefail
# A patch of the Anonymous Pro font that includes various icon fonts
# (FontAwesome, etc). See nerdfonts.com. The Debian package `fonts-powerline`
# doesn't work for `urxvt`, so I need the patched font.

wget -O /tmp/AnonymousPro.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/AnonymousPro.zip"
unzip /tmp/AnonymousPro.zip 'Anonymice Nerd Font Complete Mono.ttf' -d ~/.fonts/
