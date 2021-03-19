#!/bin/bash
set -euo pipefail

git clone https://github.com/Tecate/bitmap-fonts.git
cd bitmap-fonts
sudo cp -avr bitmap/ /usr/share/fonts
xset fp+ /usr/share/fonts/bitmap
fc-cache -fv

cd /etc/fonts/conf.d/
#sudo rm /etc/fonts/conf.d/10*
sudo rm -rf 70-no-bitmaps.conf
sudo ln -s ../conf.avail/70-yes-bitmaps.conf .
sudo dpkg-reconfigure fontconfig

