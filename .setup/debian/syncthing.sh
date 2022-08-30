#!/bin/sh
# This enables the Syncthing service. GUI on localhost:8384
set -eu

sudo apt install syncthing
systemctl enable syncthing@$HOST.service
