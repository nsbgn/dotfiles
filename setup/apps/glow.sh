#!/bin/bash
# glow - Markdown viewer for the terminal
set -euo pipefail

sudo apt install golang
go get -u github.com/charmbracelet/glow
