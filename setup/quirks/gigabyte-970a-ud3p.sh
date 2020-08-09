#!/bin/bash
# Prevents Gigabyte 970A-UD3P motherboard from freaking out.

# First enable IOMMU in the BIOS. Then add iommu=soft (or perhaps
# amd_iommu=off) to kernel options:
sed --in-place 's/\(GRUB_CMDLINE_LINUX_DEFAULT\)="\(.*\)"/\1="\2 iommu=soft"/g' /etc/default/grub
sudo update-grub
