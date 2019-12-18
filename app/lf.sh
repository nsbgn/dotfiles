#!/bin/bash
# lf - File manager
set -euo pipefail
IFS=$'\n\t'

sudo apt install golang
go get -u github.com/gokcehan/lf
