#!/bin/bash
# `bat` shows plain file contents in a fancy way: optional syntax highlighting,
# line numbering, etcetera.
set -euo pipefail
IFS=$'\n\t'

sudo apt install llvm clang
cargo install bat
