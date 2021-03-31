#!/bin/bash
# As a VirtualBox guest
set -euo pipefail

# Insert guest additions ISO and:
sudo apt update
sudo apt install build-essential dkms linux-headers-$(uname -r)
sudo mkdir -p /mnt/cdrom # Mount guest additions
sudo mount /dev/cdrom /mnt/cdrom
cd /mnt/cdrom
sudo sh ./VBoxLinuxAdditions.run --nox11
lsmod | grep vboxguest

# Allow access to shared directories
adduser $USER vboxsf

# On every startup:
# Set up virtual display with the right resolution
xrandr --newmode $(cvt 1920 1080 60 | sed -n 's/Modeline \(.*\)/--newmode \1/p')
xrandr --addmode Virtual1 "1920x1080_60.00"
xrandr --output Virtual1 --mode 1920x1080_60.00

# Enable shared clipboard
VBoxClient --clipboard
# VBoxClient --draganddrop
# VBoxClient --seamless


