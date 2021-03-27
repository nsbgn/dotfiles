#!/bin/bash
set -euo pipefail

# Install Siji
#https://github.com/stark/siji

# Install Cozette
wget -O /tmp/cozette.otb 'https://github.com/slavfox/Cozette/releases/download/v.1.9.3/cozette.otb'
sudo mkdir /usr/share/fonts/cozette
sudo cp /tmp/cozette.otb /usr/share/fonts/cozette/

# Install Dina
wget -O /tmp/Dina.zip "https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61"
unzip -d ~/.fonts/Dina /tmp/Dina.zip
cd ~/.fonts/Dina/BDF
sudo mkfontscale
sudo mkfontdir
sudo dpkg-reconfigure fontconfig-config
fc-cache -f

# Install other fonts
git clone https://github.com/Tecate/bitmap-fonts.git ~/.builds/bitmap-fonts
sudo cp -avr ~/.builds/bitmap-fonts/bitmap/ /usr/share/fonts
cd /usr/share/fonts/bitmap
sudo mkfontdir
sudo mkfontscale
xset fp+ /usr/share/fonts/bitmap
fc-cache -fv

# Make sure bitmaps are accepted
cd /etc/fonts/conf.d/
#sudo rm /etc/fonts/conf.d/10*
sudo rm -rf 70-no-bitmaps.conf
sudo ln -s ../conf.avail/70-yes-bitmaps.conf ./
sudo dpkg-reconfigure fontconfig

