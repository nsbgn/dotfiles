#!/bin/bash
# jq - JSON processing for the shell.
# jq 1.5 is in Debian repos but is outdated.
set -euo pipefail

wget -O ~/.local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64"
chmod +x ~/.local/bin/jq
