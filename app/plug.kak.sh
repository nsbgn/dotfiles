#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

mkdir -p ~/.config/kak/plugins/
git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak
