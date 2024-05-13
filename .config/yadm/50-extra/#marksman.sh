#!/bin/bash
# Markdown language server
# https://github.com/artempyanykh/marksman

wget -O ~/.local/bin/marksman "$( \
    curl -s 'https://api.github.com/repos/artempyanykh/marksman/releases/latest' \
    | jq -r '.assets | .[] | .browser_download_url | select(endswith("-linux-x64"))'\
)"
chmod +x ~/.local/bin/marksman
