#!/bin/sh
# Hurl - Text-focused Postman alternative
# <https://github.com/Orange-OpenSource/hurl>

PREFIX="${HOME}/.local/bin"
TMP="$(mktemp -d)"
BIN="${PREFIX}/hurl"
if [ ! -f "${BIN}" ]; then
mkdir -p ${PREFIX}
curl -fL "$( \
    curl -fL 'https://api.github.com/repos/Orange-OpenSource/hurl/releases/latest' \
    | jq -r '.assets[].browser_download_url | select(endswith("x86_64-unknown-linux-gnu.tar.gz"))' \
)" | tar -xvz -C "${TMP}"
cp ${TMP}/hurl-*/bin/hurl "${BIN}"
chmod +x "${BIN}"
fi
