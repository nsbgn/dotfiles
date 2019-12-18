#!/bin/bash
# This script sets me up to automatically log in without being prompted, which
# makes sense for me because my system is single-user and full-disk encryption
# blocks physical access.
set -euo pipefail
IFS=$'\n\t'

# System should boot to TTY rather than display manager. Set to
# graphical.target to reverse.
sudo systemctl set-default multi-user.target

# Auto-login the current user on TTY1
sudo mkdir -p '/etc/systemd/system/getty@tty1.service.d'
sudo tee '/etc/systemd/system/getty@tty1.service.d/override.conf' << EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER --noclear %I \$TERM
EOF
