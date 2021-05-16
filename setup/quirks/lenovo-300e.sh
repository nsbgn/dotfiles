#!/bin/bash
set -euo pipefail

# Make backlight work
sudo tee -a /usr/share/X11/xorg.conf.d/51-backlight.conf << EOF
Section "Device"
	Identifier "Card0"
	Driver "intel"
	Option "Backlight" "/sys/class/backlight/intel_backlight"
EndSection
EOF


