#!/bin/sh
set -e

FILE="$1"
shift

awk 'NR==1 && $0=="---" {x=1} NR>1 {if(x==1 && $0=="---") x=0; else print} ' "$FILE" \
    | /usr/bin/lowdown $@
