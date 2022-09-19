#!/bin/sh
#
# <https://inai.de/projects/pam_mount/>
set -eu

# grep -q alpine /etc/os-release || exit 1
# sudo apt install libhx-dev libpam-dev
# doas apk add autoconf autoconf-archive automake libtool

DIR="$HOME/.builds/pam_mount"

mkdir -p "$DIR"
git clone https://git.inai.de/pam_mount "$DIR"
cd "$DIR"
sh autogen.sh
sh configure
make
sudo make install
