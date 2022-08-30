#!/bin/sh
# Enable file-level encryption on login using fscrypt. For device-level
# encryption on Linux, use dm-crypt; for cross-platform device-level
# encryption, use VeraCrypt.
#
# <https://wiki.debian.org/TransparentEncryptionForHomeFolder>
# <https://www.rohanjain.in/fscrypt/>
# <https://wiki.archlinux.org/title/Fscrypt#Encrypt_a_home_directory>
# <https://www.linuxinsider.com/story/get-no-fuss-file-level-crypto-with-fscrypt-86953.html>
# <https://github.com/google/fscrypt>
# <https://wiki.archlinux.org/title/Fscrypt>
# <https://wiki.archlinux.org/title/PAM>
#
# gocryptfs:
# <https://github.com/rfjakob/gocryptfs/wiki/Mounting-on-login-using-pam_mount>

set -e

grep -q debian /etc/os-release || exit 1

# sudo apt-get install gocryptfs libpam-mount
sudo apt-get install fscrypt libpam-fscrypt

# Find device on which HOME is mounted
DEV=$(findmnt -n -o SOURCE --target "$HOME")

# Make sure it is formatted as ext4
test $(findmnt -n --source "$DEV" -o fstype) == "ext4" || exit 1

# Enable `encrypt` feature flag on the device
sudo tune2fs -O encrypt "$DEV"

sudo fscrypt setup
# sudo setup $HOME # Only if not on root filesystem

# Append this to the auth section
sudo tee -a /etc/pam.d/system-login << EOF
auth       optional   pam_fscrypt.so
EOF

# Insert this before `session include system-auth`
sudo tee -a /etc/pam.d/system-login << EOF
session    [success=1 default=ignore]  pam_succeed_if.so  service = systemd-user quiet
session    optional                    pam_fscrypt.so
EOF
# Note: The first line, taken from https://github.com/google/fscrypt/issues/95,
# is a bypass for the systemd --user session which doesn't properly close its
# PAM session and would otherwise block the locking on logout.

sudo tee -a /etc/pam.d/passwd << EOF
password    optional    pam_fscrypt.so
EOF

mkdir /home/$USER.crypt
sudo chown $USER:$USER /home/$USER.crypt
sudo fscrypt encrypt /home/$USER.crypt --user=$USER
fscrypt status /home/newhome

# ... That's all.
# fscrypt lock /home/$USER --user=$USER
