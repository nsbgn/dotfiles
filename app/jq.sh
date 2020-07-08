#!/bin/bash
# jq 1.5 is in Debian repos but is outdated.

wget -O ~/.local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64"
chmod +x ~/.local/bin/jq

