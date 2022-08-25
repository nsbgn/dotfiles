#!/bin/sh
#
# - For device-level encryption on Linux, use dm-crypt.
# - For cross-platform device-level encryption, use VeraCrypt.
# - For home directory encryption, I would prefer fscrypt. However, Alpine
# Linux doesn't have the userspace tool in their repositories, so gocryptfs is
# also an option.
#
# https://wiki.debian.org/TransparentEncryptionForHomeFolder
#
# fscrypt:
#   https://www.rohanjain.in/fscrypt/
#   https://wiki.archlinux.org/title/Fscrypt#Encrypt_a_home_directory
#   https://www.linuxinsider.com/story/get-no-fuss-file-level-crypto-with-fscrypt-86953.html
#
# gocryptfs:
#   https://github.com/rfjakob/gocryptfs/wiki/Mounting-on-login-using-pam_mount

set -e

if grep -q debian /etc/os-release; then

# sudo apt-get install gocryptfs libpam-mount
sudo apt-get install fscrypt libpam-fscrypt

# Enable encryption on the ext4-formatted root partition (at least, maybe add
# home partition)
ROOTPARTITION="/dev/disk/by-uuid/$(lsblk -oUUID,MOUNTPOINT | grep /$ | cut -d' ' -f1)"
sudo tune2fs -O encrypt ${ROOTPARTITION}

# Actually encrypt --- make sure /home/$USER is empty
sudo fscrypt setup
sudo fscrypt encrypt /home/$USER --user=$USER

# ... That's all.
# fscrypt lock /home/$USER --user=$USER

fi
