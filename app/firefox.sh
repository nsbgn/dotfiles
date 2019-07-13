#!/bin/bash
# Firefox - Web browser

wget -O /tmp/firefox.tar.bz2 --content-disposition "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64&lang=en-US" \
    && sudo rm -rf /opt/firefox \
    && sudo tar xjf /tmp/firefox.tar.bz2 -C/opt
