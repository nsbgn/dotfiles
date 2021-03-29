#!/bin/bash
set -euo pipefail

for FILE in "$(dirname $0)"/*; do
    NAME="$(basename $FILE)"
    if [ -d "$FILE" -o "$NAME" == "user-dirs.dirs" ]; then
        DEST="$HOME/.config/$NAME"
    else
        DEST="$HOME/.$NAME"
    fi
    
    echo "Linking $FILE to $DEST"
    # overwrite symbolic links but nothing else
    if [ -L "$DEST" ]; then
        ln -srTf "$FILE" "$DEST"
    else
        ln -srT "$FILE" "$DEST"
    fi

done
