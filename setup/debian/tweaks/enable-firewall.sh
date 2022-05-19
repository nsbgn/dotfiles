#!/bin/bash
# Firewall
# https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29
# https://www.linuxbabe.com/security/ufw-firewall-debian-ubuntu-linux-mint-server
set -euo pipefail

sudo apt-get install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow Transmission
sudo ufw enable
sudo ufw status verbose
