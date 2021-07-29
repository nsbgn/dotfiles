#!/bin/bash
# Bitmap fonts, which look better at small resolutions
# Of particular interest:
#   - Dina: https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61
#   - Cozette: https://github.com/slavfox/Cozette
#   - Siji: https://github.com/stark/siji
set -euo pipefail

# Install Cozette
wget -O /tmp/cozette.otb 'https://github.com/slavfox/Cozette/releases/download/v.1.9.3/cozette.otb'
sudo mkdir /usr/share/fonts/cozette
sudo cp /tmp/cozette.otb /usr/share/fonts/cozette/

# Install other fonts (Dina, Siji among others)
git clone https://github.com/Tecate/bitmap-fonts.git ~/.builds/bitmap-fonts
sudo cp -avr ~/.builds/bitmap-fonts/bitmap/ /usr/share/fonts
cd /usr/share/fonts/bitmap
sudo mkfontdir
sudo mkfontscale
fc-cache -fv

xset fp+ /usr/share/fonts/bitmap/*
xset fp rehash
