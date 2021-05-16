#!/bin/bash
# The Rust toolchain. Debian also provides rustc and cargo individually.
set -euo pipefail

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
