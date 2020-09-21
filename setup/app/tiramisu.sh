#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

git clone https://github.com/Sweets/tiramisu
cd tiramisu
make
chmod +x tiramisu
sudo cp tiramisu /usr/local/bin/tiramisu
