#!/bin/bash
# readability - Readability library to strip webpages to just the text and
# images. For the CLI.
# https://gitlab.com/gardenappl/readability-cli
set -euo pipefail
IFS=$'\n\t'

npm install -g @gardenapple/readability-cli
