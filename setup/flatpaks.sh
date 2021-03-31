#!/bin/bash
# This installs Flatpak and install software from the Flathub repository that I
# don't get from the official repos or the backports repo
set -euo pipefail

# Setup
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Media center (Debian one has issues with display & joystick input)
flatpak install flathub tv.kodi.Kodi

# GC/Wii emulator (no longer in Debian)
flatpak install flathub org.DolphinEmu.dolphin-emu

# Xonotic game because it is (not in Debian)
flatpak install flathub org.xonotic.Xonotic

# Soulseek client (no longer in Debian)
flatpak install flathub org.nicotine_plus.Nicotine

# OpenRCT2 Rollercoaster Tycoon reimplementation (not in Debian)
flatpak install flathub io.openrct2.OpenRCT2

# flatpak install flathub org.netsurf_browser.NetSurf
