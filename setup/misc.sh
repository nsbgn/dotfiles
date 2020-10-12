#!/bin/bash
# Miscellaneous tweaks
set -euo pipefail

# Link OpenMW saves so that they get synced
ln -s ~/.gamestates/OpenMW ~/.local/share/openmw/saves 
