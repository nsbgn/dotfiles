#!/bin/sh
# Update Debian automatically
set -eu

sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
