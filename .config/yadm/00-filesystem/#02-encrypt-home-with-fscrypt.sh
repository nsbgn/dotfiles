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

if test $(id -u) -ne 0; then
    echo "Must run as root"; exit 1
fi
TARGET_USER=$1
if test -z "$TARGET_USER"; then
    TARGET_USER=nsbg
fi

# Make sure that there are no non-hidden files in $HOME
test -z "$(ls "$HOME")" || exit 1

# Make sure that $HOME is not yet encrypted
fscrypt status "$HOME" || exit 1

# Make sure that fscrypt et al are installed
if ! which fscrypt; then
    if grep -q debian /etc/os-release; then
        sudo apt-get install fscrypt libpam-fscrypt e2fsprogs util-linux
    elif grep -q alpine /etc/os-release; then
        cd
        doas apk add git make gcc go m4 linux-pam-dev e2fsprogs-extra findmnt
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
fi

# Find device on which $HOME is mounted
DEV=$(findmnt -n -o SOURCE --target "$HOME")

# Make sure it is formatted as ext4
test $(findmnt -n --source "$DEV" -o fstype) == "ext4" || exit 1

# Enable `encrypt` feature flag on the device and set up encryption
sudo tune2fs -O encrypt "$DEV"
sudo fscrypt setup

if grep -q debian /etc/os-release; then
    # Debian installs defaults for fscrypt here
    test -e /usr/share/pam-configs/fscrypt
    sudo pam-auth-update

elif grep -q alpine /etc/os-release; then
    # TODO pam-fscrypt seems to segfault on Alpine. Need to investigate.
    exit 1

    echo "auth required pam_unix.so" | tee /etc/pam.d/fscrypt
    sed -i '$aauth optional pam_fscrypt.so' /etc/pam.d/base-auth
    sed -i '1ipassword optional pam_fscrypt.so' /etc/pam.d/base-password
    sed -i '$asession optional pam_fscrypt.so' /etc/pam.d/base-session
else
    exit 1
fi

# Encrypt a new directory
CRYPT=/home/$USER.crypt
sudo mkdir "$CRYPT"
sudo chown $USER:$USER "$CRYPT"
sudo fscrypt encrypt "$CRYPT" --user=$USER --source=pam_passphrase

# ... That's all.
# fscrypt lock /home/$USER --user=$USER


