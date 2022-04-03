#!/bin/bash
# Update automatically
set -euo pipefail

sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades
