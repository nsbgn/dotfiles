#!/bin/bash
# The Haskell stack. Debian also provides haskell-stack, but it is outdated.
set -euo pipefail
IFS=$'\n\t'

curl -sSL https://get.haskellstack.org/ | sh
