#!/bin/bash
# Generate ASCII diagrams
# <https://arthursonzogni.com/Diagon>
#
# For this purpose, also consider GraphEasy:
# <https://metacpan.org/dist/Graph-Easy>
# On Debian: sudo apt install libgraph-easy-perl
# Or:
# https://github.com/povilasb/neovim-ascii-diagram
# https://github.com/jbyuki/venn.nvim
# Or:
# https://asciiflow.com/#/

TMP="$(mktemp)"
wget -O "$TMP" "$( \
    curl -s 'https://api.github.com/repos/ArthurSonzogni/Diagon/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | 
select(endswith("-Linux.zip")))' \
)"
unzip -d "$HOME/.local" "$TMP" "diagon*/*"
rm "$TMP"
