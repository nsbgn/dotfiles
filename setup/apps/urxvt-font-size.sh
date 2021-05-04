#!/bin/bash
set -euo pipefail

git clone https://github.com/majutsushi/urxvt-font-size ~/.builds/urxvt-font-size
mkdir -p ~/.urxvt/ext
cp ~/.builds/urxvt-font-size/font-size ~/.urxvt/ext/
