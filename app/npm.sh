#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Install NPM
sudo apt install npm

# Avoid access permissions https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Install Stack Overflow on command line
npm install -g jshint

# Install JSON viewer
npm install -g fx
