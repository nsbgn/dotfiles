#!/bin/sh
# TUI file explorer
# https://github.com/sayanarijit/xplr

DIR="$HOME/.local/bin"
BIN="xplr"

if [ ! -f "$DIR/$BIN" ]; then
    TMPDIR="$(mktemp -d /tmp/cozette-XXX)"
    trap "rm -rf $TMPDIR" EXIT
    platform="linux"  # "linux-musl"
    cd "$TMPDIR"
    wget https://github.com/sayanarijit/xplr/releases/latest/download/xplr-$platform.tar.gz
    tar xzvf xplr-$platform.tar.gz
    sudo mv xplr $DIR/
fi
