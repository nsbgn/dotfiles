#!/bin/ash
# Dual (or triple) boot 
# <https://wiki.archlinux.org/title/Dm-crypt>
# <https://wiki.alpinelinux.org/wiki/LVM_on_LUKS>
# <https://wiki.gentoo.org/wiki/Full_Disk_Encryption_From_Scratch_Simplified>
# <https://gitlab.com/cryptsetup/cryptsetup>
# <https://ungleich.ch/u/blog/encrypted-rootfs-with-alpine-linux/>
# <https://battlepenguin.com/tech/alpine-linux-with-full-disk-encryption/>
set -eu

setup-keymap us us
setup-timezone Europe/Amsterdam
setup-interface -a
setup-ntp chrony
setup-apkrepos -c -f
setup-user -a nsbg

DISK="/dev/sda"

apk add parted e2fsprogs dosfstools efibootmgr grub-efi cryptsetup cryptsetup-openrc

# Make partition table
parted --script "$DISK" -- \
    mklabel gpt \
    mkpart \"efi\" fat32 0% 512MiB \
    mkpart \"swap\" swap 512MiB 8GiB \
    mkpart \"alpine\" ext4 8GiB 24GiB \
    mkpart \"debian\" ext4 24GiB 40GiB \
    mkpart \"home\" 40GiB 100% \
    set 1 boot on \
    set 1 esp on

# Setup Alpine root
mkfs.ext4 "${DISK}3"
mount -t ext4 "${DISK}3" /mnt

# Setup boot partition
mkfs.fat -F 32 "${DISK}1"
modprobe vfat
mkdir -p /mnt/boot/efi
mount "${DISK}1" /mnt/boot/efi

# Install Alpine system to these partitions
BOOTLOADER=grub USE_EFI=1 setup-disk sys /mnt

# Setup home partition
doas cryptsetup luksFormat -v "${DISK}5"
doas cryptsetup open "${DISK}5" crypthome
doas mkfs -t ext4 /dev/mapper/crypthome
doas cryptsetup close crypthome

doas rc-update add dmcrypt boot

# To add a key:
#   doas cryptsetup luksAddKey "$DEV" $HOME/.luks/key.bin

# To create a backup:
#   cryptsetup luksHeaderBackup "$DEV" --header-backup-file $HOME/.luks/backup.img
