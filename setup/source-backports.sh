#!/bin/bash
# This enables the backports repo and installs software from there.
set -euo pipefail

sudo tee '/etc/apt/sources.list.d/buster-backports.list' << EOF
deb http://deb.debian.org/debian buster-backports main contrib
deb-src http://deb.debian.org/debian buster-backports main contrib
EOF

sudo apt -t buster-packports install polybar
sudo apt -t buster-packports install weasyprint
