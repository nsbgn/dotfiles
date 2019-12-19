#!/bin/bash
# Dina - Font
set -euo pipefail
IFS=$'\n\t'

wget -O /tmp/Dina.zip "https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61"
sudo unzip -d /usr/share/fonts/Dina /tmp/Dina.zip
cd /usr/share/fonts/Dina/BDF
sudo mkfontscale
sudo mkfontdir
sudo dpkg-reconfigure fontconfig-config
fc-cache -f
