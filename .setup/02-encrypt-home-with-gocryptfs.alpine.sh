#!/bin/sh
# Enable file-level encryption on login using gocryptfs
# <https://wiki.archlinux.org/title/gocryptfs>
# <https://github.com/rfjakob/gocryptfs/wiki/Mounting-on-login-using-pam_mount>
# <https://wiki.archlinux.org/title/PAM>

# ... pam_mount isn't in Alpine. cf.
# <https://gitlab.alpinelinux.org/alpine/aports/-/issues/13758>
# TODO
exit 1

grep -q alpine /etc/os-release || exit 1
test -z "$(ls -A $HOME)"

# doas apk add linux-pam gocryptfs
# doas mkdir /home/$USER.cipher
# doas chown $USER /home/$USER.cipher
# gocryptfs -init /home/$USER.cipher
