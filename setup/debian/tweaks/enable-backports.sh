#!/bin/bash
# Add backports repo
set -euo pipefail

sudo tee -a /etc/apt/sources.list << EOF
deb http://deb.debian.org/debian bullseye-backports main contrib non-free
deb-src http://deb.debian.org/debian bullseye-backports main contrib non-free
EOF

sudo apt update
