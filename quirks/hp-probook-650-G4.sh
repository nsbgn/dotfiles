#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

sudo tee '/usr/share/X11/xorg.conf.d/20-intel.conf' << EOF
Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "AccelMethod" "sna"
    Option "Backlight" "intel_backlight"
EndSection
EOF

sudo tee '/etc/modprobe.d/pcspkr-blacklist.conf' << EOF
blacklist pcspkr
EOF
