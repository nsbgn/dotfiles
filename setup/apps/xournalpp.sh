#!/bin/bash
# xournal++ - A notetaking app for touchscreens with active stylus. Its
# predecessor Xournal is in the debian repositories but doesn't work quite as well
# https://xournalpp.github.io/
set -euo pipefail

sudo apt install libjack-dev libportaudiocpp0 liblua5.3-0 libportaudio2

mkdir -p ~/.builds/debs
wget -P ~/.builds/debs/ "$( \
    curl -s 'https://api.github.com/repos/xournalpp/xournalpp/releases/latest' \
    | jq -r 'first(.assets | .[] | .browser_download_url | select(endswith("x86_64.deb")))'\
)"
sudo dpkg -i ~/.builds/debs/xournalpp*.deb
