#!/bin/sh
# Make sure bitmap fonts are accepted --- they look better at small resolutions
set -euo pipefail

cd /etc/fonts/conf.d/
sudo rm -rf 70-no-bitmaps.conf
sudo ln -s ../conf.avail/70-yes-bitmaps.conf ./
sudo dpkg-reconfigure fontconfig
# sudo dpkg-reconfigure fontconfig-config
