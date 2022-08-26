#!/bin/sh
# Markdown files are generated from the filename, not just copied

tee << EOF
---
title: $(basename -s .md "$(echo $@ | sed 's/^[0-9]+ //g;s/.*/\u&/')")
date: $(date +'%Y-%m-%d')
author: $USER
lang: $(echo $LANG | cut -d. -f1 | tr '_' '-')
license: <https://creativecommons.org/licenses/by/4.0/>
uuid: $(uuidgen -r)
---
EOF
