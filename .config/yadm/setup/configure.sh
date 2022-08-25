#!/bin/bash
# Puts all configuration files in the right places.
set -euo pipefail

root="$(realpath $(dirname $0)/../../..)"

# echo "Copying keyd config"
# sudo cp "$root/config/keyd/default.conf" /etc/keyd/default.conf
# sudo systemctl restart keyd

mkdir -p ~/.local/share
[ -L ~/.local/share/applications ] && \
    ln -srTf $root/.local/share/applications ~/.local/share/applications || \
    :

mkdir -p ~/.config

link(){
    FILE=$1
    DEST=$2
    echo "$FILE -> $DEST"
    # overwrite symbolic links but nothing else
    if [ -L "$DEST" ]; then
        ln -srTf "$FILE" "$DEST" || :
    else
        ln -srT "$FILE" "$DEST" || :
    fi
}

for FILE in "$root"/.*; do
    if [ -f "$FILE" ]; then
        link "$FILE" "$HOME/$(basename $FILE)"
   fi
done

for FILE in "$root"/.config/*; do
    link "$FILE" "$HOME/.config/$(basename $FILE)"
done
