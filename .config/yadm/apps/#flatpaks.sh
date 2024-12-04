#!/bin/sh
# This installs Flatpak and install software from the Flathub repository that I
# don't get from the official repos or the backports repo
set -e

# Setup
if grep -q debian /os-release; then
    sudo apt install flatpak
else
    sudo apk add flatpak
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# GC/Wii emulator (no longer in Debian)
flatpak install flathub org.DolphinEmu.dolphin-emu

# Xonotic game because it is (not in Debian)
flatpak install flathub org.xonotic.Xonotic

# OpenRCT2 Rollercoaster Tycoon reimplementation (not in Debian)
flatpak install flathub io.openrct2.OpenRCT2

# Soulseek client (no longer in Debian)
flatpak install flathub org.nicotine_plus.Nicotine
