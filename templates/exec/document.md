#!/bin/bash
# Markdown files are generated, not just copied

tee << EOF
---
title: $(basename -s .md "$(echo $@ | tr '-' ' ')")
date: $(date +'%Y-%m-%d')
author: $USER
uuid: $(uuidgen -r)
tags: []
---
EOF