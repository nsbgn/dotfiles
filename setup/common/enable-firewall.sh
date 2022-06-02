#!/bin/sh
# Firewall
# https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29
# https://www.linuxbabe.com/security/ufw-firewall-debian-ubuntu-linux-mint-server
set -e

if grep -q debian /etc/os-release; then
    sudo apt-get install ufw
else
    sudo apk add ufw
fi

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow Transmission
sudo ufw allow syncthing
sudo ufw enable
sudo ufw status verbose
