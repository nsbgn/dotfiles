#!/bin/bash
# This enables the Syncthing service. GUI on localhost:8384
set -euo pipefail

sudo apt install syncthing
systemctl enable syncthing@$HOST.service
