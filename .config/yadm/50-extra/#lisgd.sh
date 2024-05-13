#!/bin/sh
# Gesture recognition
# cf. https://www.laubersheimer.eu/2021/08/08/using-lisgd-and-i3-on-a-convertible-laptop.html#configuring-udev

set -e

RULE=/etc/udev/rules.d/99-lisgd-device.rules
# https://www.laubersheimer.eu/2021/08/08/using-lisgd-and-i3-on-a-convertible-laptop.html#configuring-udev
sudo apt install lisgd
if [ ! -e "$RULE" ]; then
sudo tee "$RULE" <<EOF
ACTION=="add", SUBSYSTEM=="input", KERNEL=="event[0-20]*", ENV{ID_INPUT_TOUCHSCREEN}=="1", MODE:="0666" GROUP="$USER", SYMLINK+="input/touchscreen"
EOF
fi
