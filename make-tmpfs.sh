#!/bin/bash
# Make /tmp a tmpfs

if ! grep -q '^tmpfs\s\+/tmp\s' /etc/fstab; then
    echo "tmpfs /tmp tmpfs rw,nosuid,nodev" | sudo tee -a /etc/fstab
fi
