#!/bin/bash
# When you have have multiple full-disk encrypted drives that you'd like to
# unlock simultaneously, you can do that by adding keyscript=decrypt_keyctl to
# both drives in /etc/crypttab
# - http://web.math.rochester.edu/people/faculty/akrish11//2018/04/28/debian-cryptroot.html
# - https://unix.stackexchange.com/questions/392284/using-a-single-passphrase-to-unlock-multiple-encrypted-disks-at-boot
set -euo pipefail

sudo apt install keyutils
sudo sed --in-place 's/\(.+\)/\1,keyscript=decrypt_keyctl/g' /etc/crypttab
sudo update-initramfs -u
