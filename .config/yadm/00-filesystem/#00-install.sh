#!/bin/ash

# Initial install

tee ANSWERFILE << EOF
KEYMAPOPTS="us us"
HOSTNAMEOPTS="-n alpine"
INTERFACEOPTS="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
    hostname alpine"
TIMEZONEOPTS="-z Europe/Amsterdam"
# APKREPOSOPTS="-r"
SSHDOPTS="-c openssh"
NTPOPTS="-c openntpd"
DISKOPTS="-m data /dev/sda"
EOF

setup-alpine -f ANSWERFILE


