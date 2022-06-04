#!/bin/sh
# Extra setup for VirtualBox guests
# <https://wiki.debian.org/VirtualBox>
# <https://wiki.alpinelinux.org/wiki/VirtualBox_guest_additions>
set -e

if grep -q debian /etc/os-release; then

# See https://fasttrack.debian.net/
sudo apt install fasttrack-archive-keyring
sudo tee -a /etc/apt/sources.list<<EOF
deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib
deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-backports-staging main contrib
EOF
sudo apt update
sudo apt install virtualbox virtualbox-guest-x11 virtualbox-guest-dkms

# Insert guest additions ISO and:
# sudo apt update
# sudo apt install build-essential dkms linux-headers-$(uname -r)
# sudo mkdir -p /mnt/cdrom # Mount guest additions
# sudo mount /dev/cdrom /mnt/cdrom
# cd /mnt/cdrom
# sudo sh ./VBoxLinuxAdditions.run --nox11
# lsmod | grep vboxguest

# # Allow access to shared directories
# adduser $USER vboxsf

# # On every startup:
# # Enable shared clipboard & set right resolution
# # See $(cvt 1920 1080 60 | sed -n 's/Modeline \(.*\)/--newmode \1/p')
# tee -a ~/.xinitrc <<EOF
# xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
# xrandr --addmode Virtual1 "1920x1080_60.00"
# xrandr --output Virtual1 --mode 1920x1080_60.00
# VBoxClient --clipboard
# EOF

# fi
