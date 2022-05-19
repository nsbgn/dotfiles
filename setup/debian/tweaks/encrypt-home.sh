#!/bin/bash
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

set -euo pipefail

sudo apt-get install libpam-mount
