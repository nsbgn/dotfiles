#!/bin/sh
# Enable file-level encryption on login using `fscrypt`.
#
# For device-level encryption on Linux, use dm-crypt; for cross-platform
# device-level encryption, use VeraCrypt.
#
# <https://wiki.debian.org/TransparentEncryptionForHomeFolder>
# <https://www.rohanjain.in/fscrypt/>
# <https://wiki.archlinux.org/title/Fscrypt#Encrypt_a_home_directory>
# <https://www.linuxinsider.com/story/get-no-fuss-file-level-crypto-with-fscrypt-86953.html>
# <https://github.com/google/fscrypt>
# <https://wiki.archlinux.org/title/Fscrypt>
# <https://wiki.archlinux.org/title/PAM>
# <https://wiki.gentoo.org/wiki/PAM>
#
# Alternatively, consider:
# <https://wiki.archlinux.org/title/gocryptfs>
# <https://github.com/rfjakob/gocryptfs/wiki/Mounting-on-login-using-pam_mount>

set -eu

distro(){
    grep -q "$1" /etc/os-release
    exit $?
}

if distro debian; then
    sudo apt-get install fscrypt libpam-fscrypt
elif distro alpine; then
    cd
    doas apk add git make gcc go m4 linux-pam-dev e2fsprogs-extra
    git clone https://github.com/google/fscrypt
    cd fscrypt
    make
    doas make install PREFIX=
    alias sudo="doas"

    # Default login isn't linked to pam
    doas apk add shadow-login
else
    exit 1
fi

# Make sure that $HOME is not yet encrypted
fscrypt status "$HOME" || exit 1

# Find device on which $HOME is mounted
DEV=$(findmnt -n -o SOURCE --target "$HOME")

# Make sure it is formatted as ext4
test $(findmnt -n --source "$DEV" -o fstype) == "ext4" || exit 1

# Enable `encrypt` feature flag on the device and set up encryption
sudo tune2fs -O encrypt "$DEV"
sudo fscrypt setup

# Debian installs defaults for fscrypt here
if distro debian && test -e /usr/share/pam-configs/fscrypt; then
    sudo pam-auth-update

elif distro alpine; then

doas tee /etc/pam.d/fscrypt << EOF
auth        required    pam_unix.so

# Append this to the auth section
sudo tee -a /etc/pam.d/system-login << EOF
auth       optional   pam_fscrypt.so
EOF

# Insert this before `session include system-auth`. Note: The first line, taken
# from https://github.com/google/fscrypt/issues/95, is a bypass for the systemd
# --user session which doesn't properly close its PAM session and would
# otherwise block the locking on logout.
sudo tee -a /etc/pam.d/system-login << EOF
session    [success=1 default=ignore]  pam_succeed_if.so  service = systemd-user quiet
session    optional                    pam_fscrypt.so
EOF

sudo tee -a /etc/pam.d/passwd << EOF
password    optional    pam_fscrypt.so
EOF

else
    exit 1
fi

CRYPT=/home/$USER.crypt
sudo mkdir $CRYPT
sudo chown $USER:$USER $CRYPT
sudo fscrypt encrypt $CRYPT --user=$USER --source=pam_passphrase
fscrypt status $CRYPT

# Make sure that $HOME is empty
test -z "$(ls -A $HOME)" || exit 1

# ... That's all.
# fscrypt lock /home/$USER --user=$USER


