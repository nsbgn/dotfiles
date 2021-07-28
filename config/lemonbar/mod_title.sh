#!/bin/sh

#bspc subscribe node_focus | cut -d' ' -f4 | xargs -n1 xdotool getwindowtitle


bspc subscribe desktop_focus node_focus | while read e a b c; do
    if [ "$e" = "node_focus" ]; then
        xdotool getwindowname $c
    else
        echo
    fi
done
