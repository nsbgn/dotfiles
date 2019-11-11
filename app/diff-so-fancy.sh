#!/bin/bash
# Diffs with diff within lines too
# See https://github.com/so-fancy/diff-so-fancy

curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy > ~/.local/bin/diff-so-fancy 
chmod +x ~/.local/bin/diff-so-fancy

# use in git
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
