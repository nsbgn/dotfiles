#!/bin/bash
set -euo pipefail

sudo cp default.conf /etc/keyd/
sudo systemctl restart keyd
sleep 1
xset r rate 300 45
setxkbmap -option compose:menu
