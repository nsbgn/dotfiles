#!/bin/ash
# Dual (or triple) boot 
# <https://wiki.archlinux.org/title/Dm-crypt>
# <https://wiki.alpinelinux.org/wiki/LVM_on_LUKS>
set -eu

DISK="/dev/sda"

# Make partition table
apk add parted
parted --script "$DISK" -- \
    mklabel gpt \
    mkpart \"efi\" fat32 0% 512MiB \
    mkpart \"swap\" swap 512MiB 8GiB \
    mkpart \"alpine\" ext4 8GiB 24GiB \
    mkpart \"debian\" ext4 24GiB 40GiB \
    mkpart \"home\" 40GiB 100% \
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

DEV=/dev/sda

doas cryptsetup luksFormat -v "$DEV"
doas cryptsetup open "$DEV" cryptroot
doas mkfs -t ext4 /dev/mapper/cryptroot
doas cryptsetup close cryptroot

### To add a key:
# doas cryptsetup luksAddKey "$DEV" $HOME/.luks/key.bin

### To create a backup:
# cryptsetup luksHeaderBackup "$DEV" --header-backup-file $HOME/.luks/backup.img
