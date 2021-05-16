#!/bin/bash
# youtube-dl - Streaming video downloader
set -euo pipefail

# It is also in the repositories directly, but sometimes outdated
sudo apt install python3-pip
pip3 install youtube-dl
