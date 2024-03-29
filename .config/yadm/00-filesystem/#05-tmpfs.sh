#!/bin/sh
# Make /tmp a temporary file system
set -eu

if ! grep -q '^tmpfs\s\+/tmp\s' /etc/fstab; then
    echo "tmpfs /tmp tmpfs rw,nosuid,nodev,noatime,mode=1777 0 0" | sudo tee -a /etc/fstab
fi
