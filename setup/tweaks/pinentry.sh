#!/bin/bash
# Change pinentry from terminal to GTK
set -euo pipefail

sudo update-alternatives --set pinentry /usr/bin/pinentry-gtk-2
