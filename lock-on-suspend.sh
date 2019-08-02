#!/bin/bash
# Lock on suspend

sudo tee /etc/systemd/system/wakelock.service << EOF
[Unit]
Description=Lock on suspend and forget GPG password
Before=sleep.target

[Service]
User=$USER
Environment=DISPLAY=:0
Type=oneshot
RemainAfterExit=yes
ExecStart=
ExecStart=/bin/sh -c "echo RELOADAGENT | gpg-connect-agent; i3lock"

[Install]
WantedBy=suspend.target
EOF

# Before=sleep.target
#$USER
#Type=forking
#Type=oneshot

sudo chmod +x /etc/systemd/system/wakelock.service
sudo systemctl enable wakelock
