#!/bin/sh
# <https://wiki.archlinux.org/title/gocryptfs>
# <https://github.com/rfjakob/gocryptfs/wiki/Mounting-on-login-using-pam_mount>
# <https://wiki.archlinux.org/title/PAM>
# Enable file-level encryption on login

grep -q alpine /etc/os-release || exit 1

doas apk add linux-pam

# TODO

# <volume user="$USER" fstype="fuse" options="nodev,nosuid,quiet"
# path="/usr/local/bin/gocryptfs#/home/%(USER).cipher" mountpoint="/home/%(USER)" />
