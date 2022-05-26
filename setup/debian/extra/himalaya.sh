#!/bin/bash
# himalaya
# Universal CLI e-mail client
#
# SOURCE: https://github.com/soywod/himalaya
# ALPINE: https://pkgs.alpinelinux.org/package/edge/community/x86_64/himalaya
# DEBIAN: -
set -euo pipefail

tmpdir=$(mktemp -d)
trap "rm -rf $tmpdir" EXIT

echo "Downloading latest $system release…"
curl -sLo "$tmpdir/himalaya.tar.gz" \
     "https://github.com/soywod/himalaya/releases/latest/download/himalaya-linux.tar.gz"

echo "Installing binary…"
tar -xzf "$tmpdir/himalaya.tar.gz" -C "$tmpdir"

mkdir -p "$PREFIX/bin"
cp -f -- "$tmpdir/$binary" "$PREFIX/bin/$binary"
