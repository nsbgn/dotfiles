#!/bin/bash
set -euo pipefail

# This fixes an issue
pip3 install future

# Language server
pip3 install python-language-server[all] pyls-mypy
