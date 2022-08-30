#!/bin/ash
set -e

DISK="/dev/sda"

# Make partition table
apk add parted
parted --script "$DISK" -- \
    mklabel gpt \
    mkpart \"efi\" fat32 0% 512MiB \
    mkpart \"root\" ext4 512MiB 10GiB \
    mkpart \"data\" 10GiB 100% \
    set 1 boot on \
    set 1 esp on

# Prepare partitions
apk add e2fsprogs dosfstools efibootmgr grub-efi
mkfs.fat -F 32 ${DISK}1
mkfs.ext4 "${DISK}2"
mount -t ext4 "${DISK}2" /mnt
modprobe vfat
mkdir -p /mnt/boot/efi
mount "${DISK}1" /mnt/boot/efi
export BOOTLOADER=grub USE_EFI=1
setup-disk sys /mnt
