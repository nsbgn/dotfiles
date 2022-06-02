#!/bin/sh
# Update automatically
set -e

sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
