#!/bin/bash
set -euo pipefail

function link {
    if [ -L "$2" ]; then # overwrite symbolic links but nothing else
        ln -srTf "$1" "$2"
    else
        ln -srT "$1" "$2"
    fi
}

for F in *; do
    if [ "$F" == "configure.sh" ]; then
        :
    elif [ -d "$F" -o "$F" == "user-dirs.dirs" ]; then
        link "$F" "$HOME/.config/$F"
    elif [ -f "$F" ]; then
        link "$F" "$HOME/.$F"
    fi
done
