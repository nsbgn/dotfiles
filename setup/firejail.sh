#!/bin/bash
# Sets up a sandbox for Firefox (also helpful for other applications, see
# manual and other resources) 
set -euo pipefail
IFS=$'\n\t'

sudo apt install firejail

# Additions to the firejail profile; see FIREJAIL-PROFILE(5) 
sudo tee /etc/firejail/firefox.local << EOF
whitelist $HOME/.blank.html
whitelist $HOME/.mutt.html
EOF
for $PROGRAM in telegram transmission-gtk; do
sudo tee /etc/firejail/$PROGRAM.local << EOF
join-or-start $PROGRAM
EOF
done

# Setting a symlink to firejail with the name of the program will run the
# program in the firejail. Make sure that the symlink is the first one that
# will be found in the PATH. Firecfg automates this. We add firefox manually,
# because it won't be found in /opt
sudo firecfg
sudo ln -s /usr/bin/firejail /usr/local/bin/firefox
sudo rm /usr/local/bin/{mutt,mpv}

# Note that `xdg-settings get default-web-browser` indicated I had some
# .desktop file in my `.local/share/applications` that was circumventing
# firejail when opened in some ways, so I had to delete that.

tee .local/share/applications/firefox.desktop << EOF
[Desktop Entry]
Name=firefox
GenericName=Web Browser
Icon=firefox
Type=Application
Categories=Network;WebBrowser;
Exec=firefox %u
Terminal=false
StartupNotify=false
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
Keywords=Browser
Actions=new-window;preferences;
EOF
xdg-settings get default-web-browser firefox

# There should be a new page that I can set for new windows on which Vim Vixen
# will work
tee "$HOME/.blank.html" << EOF
<html><head><title>New page</title></head><body></body></html>
EOF
