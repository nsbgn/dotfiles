#!/bin/bash
# ms-sys - For Windows master boot record writing 
# http://ms-sys.sourceforge.net/
set -euo pipefail

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/ms-sys"

wget -O /tmp/ms-sys.tar.gz "https://downloads.sourceforge.net/project/ms-sys/ms-sys%20stable/2.6.0/ms-sys-2.6.0.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fms-sys%2Ffiles%2Fms-sys%2520stable%2F2.6.0%2Fms-sys-2.6.0.tar.gz%2Fdownload%3Fuse_mirror%3Dautoselect&ts=1563091792&use_mirror=autoselect"
rm -rf "$INSTALL"
mkdir -p "$INSTALL"
tar xvf /tmp/ms-sys.tar.gz -C "$INSTALL"
cd "$INSTALL/ms-sys-2.6.0"
make
sudo make install
