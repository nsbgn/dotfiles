#!/bin/bash
# Dina - Monospace bitmap font
set -euo pipefail
IFS=$'\n\t'

wget -O /tmp/Dina.zip "https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61"
unzip -d ~/.fonts/Dina /tmp/Dina.zip
cd ~/.fonts/Dina/BDF
sudo mkfontscale
sudo mkfontdir
sudo dpkg-reconfigure fontconfig-config
fc-cache -f
