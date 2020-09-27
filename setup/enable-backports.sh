#!/bin/bash
# This enables the backports repo, to enable `apt -t buster-backports install
# "package"`
set -euo pipefail

sudo tee '/etc/apt/sources.list.d/buster-backports.list' << EOF
deb http://deb.debian.org/debian buster-backports main contrib
deb-src http://deb.debian.org/debian buster-backports main contrib
EOF
