#!/bin/bash
# Lock on suspend. Doesn't seem to fully work yet.
# See https://wiki.archlinux.org/index.php/Power_management#Sleep_hooks
# See https://askubuntu.com/questions/263867/ubuntu-suspend-works-only-once-through-lid-close
set -euo pipefail
IFS=$'\n\t'

sudo tee '/etc/systemd/system/suspend@.service' << EOF
[Unit]
Description=User suspend actions
Before=sleep.target

[Service]
User=%I
Type=forking
Environment=DISPLAY=:0
ExecStartPre= -/bin/sh -c "echo RELOADAGENT | gpg-connect-agent" ; /usr/bin/playerctl pause
ExecStart= /usr/bin/i3lock
ExecStartPost=/usr/bin/sleep 1

[Install]
WantedBy=sleep.target
EOF

sudo chmod +x '/etc/systemd/system/suspend@.service'
sudo systemctl enable "suspend@$USER"
