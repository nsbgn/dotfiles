#!/bin/bash
set -euo pipefail

git clone https://gitlab.com/jobol/mustach ~/.builds/mustach
cd mustach
make
sudo make install
