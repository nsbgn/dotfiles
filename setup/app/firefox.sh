#!/bin/bash
# firefox - Web browser
set -euo pipefail

sudo apt install firefox-esr

# For the build directly from Mozilla:
#wget -O /tmp/firefox.tar.bz2 --content-disposition "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" \
#    && sudo rm -rf /opt/firefox \
#    && sudo tar xjf /tmp/firefox.tar.bz2 -C/opt

declare -a ADDONS=( umatrix ublock-origin decentraleyes vim-vixen fire2000 )
ADDONS=("${ADDONS[@]/#/'https://addons.mozilla.org/firefox/addon/'}")


# Could also use webext-ublock-origin webext-umatrix
