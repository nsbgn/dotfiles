sudo tee '/usr/share/X11/xorg.conf.d/20-intel.conf' << EOF
Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "AccelMethod" "sna"
    Option "Backlight" "intel_backlight"
EndSection
EOF


sudo tee '/etc/X11/xorg.conf.d/40-libinput.conf' << EOF
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
EndSection
EOF


sudo tee '/etc/modprobe.d/pcspkr-blacklist.conf' << EOF
blacklist pcspkr
EOF
