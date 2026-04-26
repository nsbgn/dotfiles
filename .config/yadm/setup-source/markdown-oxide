#!/bin/sh
# <https://github.com/Feel-ix-343/markdown-oxide>

# cargo install --locked --git https://github.com/Feel-ix-343/markdown-oxide.git markdown-oxide

PREFIX="${HOME}/.local/bin"
BIN="${PREFIX}/markdown-oxide"
if [ ! -f "${BIN}" ]; then
mkdir -p ${PREFIX}
wget -O "${BIN}" "$( \
    curl -fL 'https://api.github.com/repos/Feel-ix-343/markdown-oxide/releases/latest' \
    | jq -r '.assets[].browser_download_url | select(endswith("x86_64-unknown-linux-gnu"))' \
)"
chmod +x "${BIN}"
fi
