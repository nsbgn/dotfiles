#!/bin/bash
# Nix - Functional package manager
set -euo pipefail
IFS=$'\n\t'

NIX_INSTALLER_NO_MODIFY_PROFILE=1 curl https://nixos.org/nix/install | sh
