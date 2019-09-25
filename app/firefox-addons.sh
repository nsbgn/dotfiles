#!/bin/bash

for ADDON in umatrix ublock-origin decentraleyes vim-vixen; do
    wget -O /tmp/$ADDON.xpi https://addons.mozilla.org/firefox/downloads/latest/$ADDON/addon-$ADDON-latest.xpi
done
firefox /tmp/umatrix.xpi /tmp/ublock-origin.xpi /tmp/decentraleyes.xpi /tmp/vim-vixen.xpi
