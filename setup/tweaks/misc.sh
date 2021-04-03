#!/bin/bash
# Miscellaneous tweaks
set -euo pipefail

# Link OpenMW & Dolphin saves so that they get synced
ln -s ~/log/savefiles/OpenMW ~/.local/share/openmw/saves 
ln -s ~/log/savefiles/Dolphin ~/.local/share/dolphin-emu/GC
