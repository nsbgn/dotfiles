#!/bin/bash
# fx - JSON viewer
set -euo pipefail
IFS=$'\n\t'

sudo apt install nodejs npm
sudo npm install -g fx
