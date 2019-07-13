#!/bin/bash
# Lock on suspend

sudo tee /etc/systemd/system/wakelock.service << EOF
[Unit]
Description=Lock on suspend
After=sleep.target

[Service]
User=%i
Type=forking
Environment=DISPLAY=:0
ExecStart=/usr/bin/i3lock

[Install]
WantedBy=suspend.target
WantedBy=sleep.target
EOF

sudo chmod +x /etc/systemd/wakelock.service
sudo systemctl enable wakelock
