#!/bin/bash
# bat - shows plain file contents in a fancy way: optional syntax highlighting,
# line numbering, etcetera.
set -euo pipefail

sudo apt install llvm clang
cargo install bat
