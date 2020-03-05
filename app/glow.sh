#!/bin/bash
# glow - Markdown viewer for the terminal
set -euo pipefail
IFS=$'\n\t'

sudo apt install golang
go get -u github.com/charmbracelet/glow
