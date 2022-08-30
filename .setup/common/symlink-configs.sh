#!/bin/bash
# Symlink all configuration files to the right places. This is an alternative
# to using `yadm` or a plain git repository to managing the files.
set -euo pipefail

ROOT="$(realpath $(dirname $0)/../..)"

link(){
    # overwrite symbolic links but nothing else
    FILE=$1
    DEST=$2
    echo "$FILE -> $DEST"
    if [ -L "$DEST" ]; then
        ln -srTf "$FILE" "$DEST" || :
    else
        ln -srT "$FILE" "$DEST" || :
    fi
}

mkdir -p ~/.local/share ~/.config
[ -L ~/.local/share/applications -o ! -e ~/.local/share/applications ] && \
    ln -srTf $ROOT/.local/share/applications ~/.local/share/applications || \
    :

for FILE in "$ROOT"/.*; do
    if [ -f "$FILE" ]; then
        link "$FILE" "$HOME/$(basename $FILE)"
   fi
done

for FILE in "$ROOT"/.config/*; do
    link "$FILE" "$HOME/.config/$(basename $FILE)"
done
