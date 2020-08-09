#!/bin/bash
# yj - Convert between YAML and JSON. Very useful for parsing YAML with `jq`,
# for example.
set -euo pipefail
IFS=$'\n\t'

go get -u github.com/sclevine/yj
