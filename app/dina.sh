#!/bin/bash
# Dina - Font

wget -O Dina.zip "https://www.dcmembers.com/jibsen/download/61/?wpdmdl=61"
sudo unzip -d /usr/share/fonts/Dina Dina.zip
cd /usr/share/fonts/Dina/BDF && sudo mkfontscale && sudo mkfontdir
sudo dpkg-reconfigure fontconfig-config
fc-cache -f
