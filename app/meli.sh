#!/bin/bash
# meli - Email client
# https://meli.delivery/posts/2019-12-09-alpha-release.html
set -euo pipefail
IFS=$'\n\t'

INSTALL="${LOCALBUILDS:-$HOME/.local-builds}/meli"
git clone https://git.meli.delivery/meli/meli.git "$INSTALL"
cd "$INSTALL"
make
# try without installing:
# ./target/release/meli
#make PREFIX=$HOME/.local install 
