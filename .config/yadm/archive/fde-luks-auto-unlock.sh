#!/bin/sh
# Automate decryption with TPM using dracut and systemd-cryptenroll
# Source: <https://forums.debian.net/viewtopic.php?t=158559>
# Alternatively, use Clevis: <https://gist.github.com/rmrfslashbin/6968665d44a3301830ba459e3426e27b>
# <>
# <https://usercomp.com/news/1420290/tip-optimal-fw-configuration-iptables>
# Information on different PCR banks:
#    <https://silvenga.com/posts/tpm-luks-unlock/#setup-the-tpm>


DEV=/dev/nvme0n1p3
sudo apt install dracut tmp2-tools
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 ${DEV}
sudo tee /etc/dracut.conf.d/tpm2-tss.conf << EOF
add_dracutmodules+=" tpm2-tss crypt "
EOF

# Edit /etc/default/grub and change `GRUB_CMDLINE_LINUX` to:
# GRUB_CMDLINE_LINUX="rd.auto rd.luks=1"
# Edit /etc/crypttab and comment out the line for ` ${DEV}` with a leading `#`.

sudo dracut -f
sudo update-grub
