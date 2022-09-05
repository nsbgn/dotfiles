#!/bin/sh
# Enable file-level encryption on login using `ecryptfs`.
#
# <https://wiki.debian.org/TransparentEncryptionForHomeFolder>
# <https://wiki.archlinux.org/title/ECryptfs#Encrypting_a_home_directory>

set -eu

if test $(id -u) -ne 0; then
    echo "Must run as root"; exit 1
fi
TARGET_USER=$1
if test -z "$TARGET_USER"; then
    TARGET_USER=nsbg
fi

if grep -q debian /etc/os-release; then
    apt-get install ecryptfs-utils
    ecryptfs-migrate-home -u $TARGET_USER
    pam-auth-update
elif grep -q alpine /etc/os-release; then
    apk add linux-pam ecryptfs
    apk add shadow-login  # Default login isn't linked to pam
    modprobe ecryptfs
    ecryptfs-migrate-home -u $TARGET_USER
    sed -i '$aauth required pam_ecryptfs.so unwrap' /etc/pam.d/base-auth
    sed -i '1ipassword optional pam_ecryptfs.so' /etc/pam.d/base-password
    sed -i '$asession optional pam_ecryptfs.so unwrap' /etc/pam.d/base-session
else
    exit 1
fi
