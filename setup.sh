#!/bin/bash

function link { 
    if [ -f "$1" ]; then
        mkdir -p -- "$(dirname -- "$2")" \
            && ln -T -s -i -- "$(realpath "$1")" "$2"
    else
        echo "\"$1\" does not exist"
    fi
}

link config/bashrc                      ~/.bashrc
link config/bash_profile                ~/.bash_profile
link config/Xresources                  ~/.Xresources
link config/xinitrc                     ~/.xinitrc
link config/taskrc                      ~/.taskrc
link config/vimrc                       ~/.vimrc
link config/muttrc                      ~/.muttrc
link config/mailcap                     ~/.mailcap
link config/gitconfig                   ~/.gitconfig
link config/vifmrc                      ~/.config/vifm/vifmrc
link config/zathurarc                   ~/.config/zathura/zathurarc
link config/i3                          ~/.config/i3/config
link config/polybar                     ~/.config/polybar/config
link config/sxhkdrc                     ~/.config/sxhkd/sxhkdrc
link config/bspwmrc                     ~/.config/bspwm/bspwmrc
link config/compton.conf                ~/.config/compton.conf
link config/user-dirs.dirs              ~/.config/user-dirs.dirs
