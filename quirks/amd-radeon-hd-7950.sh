#!/bin/bash
# This script sets the configuration for my AMD Radeon HD 7950.

# Check that SI support was on in the kernel
if ! grep -q "^CONFIG_DRM_AMDGPU_SI=[y|Y]$" "/boot/config-$(uname -r)"; then
    echo "Kernel was compiled without support for Southern Islands"
fi

# Set module parameters (could also be done as kernel params)
sudo tee /etc/modprobe.d/amdgpu.conf << EOF
options amdgpu si_support=1
options amdgpu cik_support=0
EOF

sudo apt install firmware-linux xserver-xorg-video-amdgpu
