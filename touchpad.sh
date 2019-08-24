#!/bin/bash
# Touchpad configuration
# See "configuration details" of libinput

sudo tee '/usr/share/X11/xorg.conf.d/41-libinput.conf' << EOF
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
        Option "ScrollMethod" "twofinger"
EndSection
EOF

