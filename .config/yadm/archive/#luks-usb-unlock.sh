#!/bin/sh
# Two layers of encryption: `LUKS` for full-disk encryption in case of hardware 
# theft, then `fscrypt` for just `/home/$USER`. Since I'd rather not enter two 
# different passwords at every boot, that first unlock can be done via a USB 
# pendrive. This also means that `/media/library` will remain unlocked, which 
# is nice.
#
# The general process:
# 1. Generate a key and add it to the LUKS container.
# 2. Add the key to a USB pendrive.
# 3. Add a script to initramfs to unlock the container with the USB.
#
### See also:
# <https://stackoverflow.com/questions/19713918/how-to-load-luks-passphrase-from-usb-falling-back-to-keyboard>
# <https://www.cemocom.de/2020/04/15/open-luks-encrypted-device-via-key-on-usb-stick/>
# <https://gist.github.com/da-n/4c77d09720f3e5989dd0f6de5fe3cbfb>
# <https://tqdev.com/2022-luks-with-usb-unlock>
#
### Extra information: Other methods of unlocking
# <https://blastrock.github.io/fde-tpm-sb.html>
# <https://tqdev.com/2022-luks-with-ssh-unlock>
#
### Extra information: Recognizing Bluetooth keyboard before login
# <https://unix.stackexchange.com/questions/42526/how-to-get-my-bluetooth-keyboard-to-be-recognized-before-log-in#42593>
#
### Extra information: Reinstalling
# <https://linuxconfig.org/how-to-install-debian-on-an-existing-luks-container>
set -eu

# Create a random passphrase:
#   dd if=/dev/urandom bs=1 count=256 > passphrase
#   cryptsetup luksAddKey /dev/sda5 passphrase

tee /bin/passphrase-from-usb <<EOF
##!/bin/sh
set -e

if ! [ -e /passphrase-from-usb-tried ]; then
    touch /passphrase-from-usb-tried
    if ! [ -e "$CRYPTTAB_KEY" ]; then
        echo "Waiting for USB stick to be recognized..." >&2
        sleep 3
    fi
    if [ -e "$CRYPTTAB_KEY" ]; then
        echo "Unlocking the disk $CRYPTTAB_SOURCE ($CRYPTTAB_NAME) from USB key" >&2
        dd if="$CRYPTTAB_KEY" bs=1 skip=129498880 count=256 2>/dev/null
        exit
    else
        echo "Can't find $CRYPTTAB_KEY; USB stick not present?" >&2
    fi
fi

/lib/cryptsetup/askpass "Unlocking the disk $CRYPTTAB_SOURCE ($CRYPTTAB_NAME)\nEnter passphrase: "
EOF

# Add the following to /etc/crypttab:
#   ... luks,keyscript=/bin/passphrase-from-usb

# Ensure that this script is available in the initramfs. 
tee /etc/initramfs-tools/hooks/passphrase-from-usb <<EOF
#!/bin/sh

PREREQ=""

prereqs() {
        echo "$PREREQ"
}

case "$1" in
        prereqs)
                prereqs
                exit 0
        ;;
esac

. "${CONFDIR}/initramfs.conf"
. /usr/share/initramfs-tools/hook-functions

copy_exec /bin/passphrase-from-usb /bin
EOF

sudo update-initramfs -u
