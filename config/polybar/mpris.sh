#!/bin/sh
# Continuously output currently playing song for displaying in polybar.

playerctl --no-messages --follow --format '{{status}} {{title}} ({{artist}} - {{album}})' metadata 2>/dev/null \
    | awk -v l=100 'NF {gsub(/^Playing/,"");gsub(/^Paused/,"");gsub(/^Stopped.*/,""); if (length($0) > l) print substr($0, 1, l-3) "..."; else print; fflush();}'
