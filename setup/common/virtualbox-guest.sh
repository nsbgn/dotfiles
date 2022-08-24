#!/bin/sh
# Extra setup for VirtualBox guests
# <https://wiki.debian.org/VirtualBox>
# <https://wiki.alpinelinux.org/wiki/VirtualBox_guest_additions>
set -e

grep -q debian /etc/os-release && exit

# See https://fasttrack.debian.net/
sudo apt install fasttrack-archive-keyring
sudo tee -a /etc/apt/sources.list<<EOF
deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-fasttrack main contrib
deb https://fasttrack.debian.net/debian-fasttrack/ bullseye-backports-staging main contrib
EOF
sudo apt update
sudo apt install virtualbox virtualbox-guest-x11 virtualbox-guest-utils
adduser $USER vboxsf
