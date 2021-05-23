#!/bin/bash

playerctl --no-messages --follow --format '{{status}}  {{title}} ({{artist}} - {{album}})' metadata \
    | grep --line-buffered . \
    | awk -v l=100 '{gsub(/^Playing/,"");gsub(/^Paused/,"");gsub(/^Stopped.*/,""); if (length($0) > l) print substr($0, 1, l-3) "..."; else print; fflush();}'
