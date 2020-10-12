#!/bin/bash
# This installs Flatpak and install software from the Flathub repository that I
# don't get from the official repos or the backports repo
set -euo pipefail

# Setup
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Kodi media center because Debian one has issues with display & joystick input
flatpak install flathub tv.kodi.Kodi

# Dolphin emulator because higher version is needed
flatpak install flathub org.DolphinEmu.dolphin-emu

# Kiwix offline wiki reader because it is not in Debian buster
flatpak install flathub org.kiwix.desktop

# Xonotic game because it is not in Debian
flatpak install flathub org.xonotic.Xonotic

# OpenRCT2 Rollercoaster Tycoon reimplementation because it not in Debian
flatpak install flathub io.openrct2.OpenRCT2
