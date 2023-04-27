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
# <https://www.cemocom.de/2020/04/15/open-luks-encrypted-device-via-key-on-usb-stick/>
# <https://stackoverflow.com/questions/19713918/how-to-load-luks-passphrase-from-usb-falling-back-to-keyboard>
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

:
