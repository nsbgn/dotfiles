#!/bin/bash
# Sets up a sandbox for Firefox (also helpful for other applications, see
# manual and other resources) 

sudo apt install firejail

SANDBOX_HOME="$HOME/.firejail/firefox"

mkdir -p "$SANDBOX_HOME"

# Additions to the firejail profile; see FIREJAIL-PROFILE(5) 
sudo tee /etc/firejail/firefox.local << EOF
# Turn on AppArmor
apparmor

# Nope
#x11 xpra
#x11 xephyr

# Mount new home directory in this directory
private $SANDBOX_HOME
EOF

# Make sure that the symlink is the first one that will be found in the PATH
# Setting a symlink to firejail with the name of the program will run the
# program in the fire
# Note that you could also just run `firecfg` to link *all* programs for which
# firejail has a profile.
ln -s /usr/bin/firejail /usr/local/bin/firefox

# There should be a new page that I can set for new windows on which Vim Vixen
# will work
tee "$SANDBOX_HOME/blank.html" << EOF
<html><head><title>new page</title></head><body></body></html>
EOF
