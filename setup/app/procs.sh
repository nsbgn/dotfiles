#!/bin/bash
# procs - Information about processes. A replacement for `ps`.
# https://github.com/dalance/procs
set -euo pipefail
IFS=$'\n\t'

cargo install procs
