#!/bin/bash
set -euo pipefail

# Use `rofi` as drop-in replacement for `dmenu`
ln -s /usr/bin/rofi ~/.local/bin/dmenu

# Debian's `bat` is not called `bat` due to name clashes
ln -s /usr/bin/batcat ~/.local/bin/bat
