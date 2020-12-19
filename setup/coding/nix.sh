#!/bin/bash
# Nix - Functional package manager
set -euo pipefail

NIX_INSTALLER_NO_MODIFY_PROFILE=1 curl https://nixos.org/nix/install | sh
