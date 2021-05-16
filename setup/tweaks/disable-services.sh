#!/bin/bash
# Turn off some services.
set -euo pipefail

for S in smbd apache2 sshd; do
    sudo systemctl disable ${S}
done
