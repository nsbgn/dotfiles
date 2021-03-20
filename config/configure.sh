#!/bin/bash
set -euo pipefail

for F in *; do
    if [ "$F" == "configure.sh" ]; then
        :
    elif [ "$F" == "user-dirs.dirs" ]; then
        ln -s -T "$(realpath --relative-to=$HOME/.config "$F")" "$HOME/.config/user-dirs.dirs" || :
    elif [ -d "$F" ]; then
        ln -s -T "$(realpath --relative-to=$HOME/.config "$F")" "$HOME/.config/$F" || :
    elif [ -f "$F" ]; then
        ln -s -T "$(realpath --relative-to=$HOME "$F")" "$HOME/.$F" || :
    fi
done
