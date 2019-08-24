#!/bin/bash
# This script sets me up to automatically log in without being prompted, which
# makes sense for me because my system is single-user and full-disk encryption
# blocks physical access. I could also do all this with a display manager, but
# since it would only be used to skip itself, that seems unnecessary.

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

# Auto-run startx when logging in to TTY1
tee ~/.bash_profile << EOF
if [[ "\$(tty)" == '/dev/tty1' ]]; then
    [[ -f "/usr/bin/startx" && -z "\$DISPLAY\$SSH_TTY\$(pgrep xinit)" ]] && exec /usr/bin/startx
    # exec /usr/bin/"$(whiptail --menu --notags --nocancel "Choose your session" 40 80 10 \
    #    "startx" "Graphical session" \
    #    "echo -n" "Terminal" \
    #    "kodi-standalone" "Media center" \
    #    "retroarch" "Games" \
    #    3>&2 2>&1 1>&3 )"
fi
EOF
