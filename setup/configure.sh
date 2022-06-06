#!/bin/bash
# Puts all configuration files in the right places.
set -euo pipefail

root="$(dirname $0)/.."

# echo "Copying keyd config"
# sudo cp "$root/config/keyd/default.conf" /etc/keyd/default.conf
# sudo systemctl restart keyd

mkdir -p ~/.local/share
[ -L ~/.local/share/applications ] && \
    ln -srTf $root/applications ~/.local/share/applications || \
    :

mkdir -p ~/.config
for FILE in "$root"/config/*; do
    NAME="$(basename $FILE)"
    if [ -d "$FILE" -o "$NAME" == "user-dirs.dirs" ]; then
        DEST="$HOME/.config/$NAME"
    else
        DEST="$HOME/.$NAME"
    fi

    echo "$FILE -> $DEST"
    # overwrite symbolic links but nothing else
    if [ -L "$DEST" ]; then
        ln -srTf "$FILE" "$DEST" || :
    else
        ln -srT "$FILE" "$DEST" || :
    fi

done
