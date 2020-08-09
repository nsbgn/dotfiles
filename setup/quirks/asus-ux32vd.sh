#!/bin/bash
# This makes the Asus UX32VD Zenbook usable.
set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Power saving
# https://github.com/Bumblebee-Project/bbswitch#disable-card-on-boot
# https://help.ubuntu.com/community/AsusZenbookPrime
# http://www.linlap.com/asus_ux32vd
# https://wiki.ubuntu.com/Kernel/PowerManagement/PowerSavingTweaks

# Install bumblebee to turn off nVidia Optimus card, and autostart it even with
# our xinit setup (check status with `sudo cat /proc/acpi/bbswitch`)
sudo apt install bumblebee primus xserver-xorg-video-nouveau
sudo tee /etc/modprobe.d/50-bumblebee.conf << EOF
options bbswitch load_state=0 unload_state=1
EOF
sudo sed --in-place 's/WantedBy=graphical.target/WantedBy=multi-user.target/g' /usr/lib/systemd/system/bumblebeed.service
sudo update-initramfs -u
sudo systemctl enable bumblebeed

# Various small, hopefully power-saving tweaks
sudo apt install tlp powertop 
sudo sed --in-place 's/\(GRUB_CMDLINE_LINUX_DEFAULT\)="\(.*\)"/\1="\2 pcie_aspm=force drm.vblankoffdelay=1 i915.semaphores=1 nmi_watchdog=0"/g' /etc/default/grub
sudo update-grub

# After disconnecting USB3 device, xhci_hcd apparently sets latency timer (see
# dmesg) which makes power consumption higher; rmmod xhci_hcd solves it
sudo tee -a /etc/modprobe.d/blacklist-xhci_hcd.conf << EOF
blacklist xhci_hcd
EOF

# No longer issue hard resets to SSD after waking up from suspend, which
# apparently solves issue reconnecting SATA connection after suspend when HDD
# is replaced with SSD.
sudo sed --in-place 's/\(GRUB_CMDLINE_LINUX_DEFAULT\)="\(.*\)"/\1="\2 libata.force=nohrst"/g' /etc/default/grub
sudo update-grub


# ALSO LOOK AT THIS
# https://www.tecmint.com/tlp-increase-and-optimize-linux-battery-life/

###############################################################################
# Encryption
# Since there is both an SSD and a HD, I'll have two encrypted drives that I'd
# like to unlock simultaneously. We do that by adding keyscript=decrypt_keyctl
# to both drives in /etc/crypttab.
# http://web.math.rochester.edu/people/faculty/akrish11//2018/04/28/debian-cryptroot.html
# https://unix.stackexchange.com/questions/392284/using-a-single-passphrase-to-unlock-multiple-encrypted-disks-at-boot

sudo apt install keyutils
sudo sed --in-place 's/\(.+\)/\1,keyscript=decrypt_keyctl/g' /etc/crypttab
sudo update-initramfs -u

# Enable TRIM by adding "rootfstype=ext4"
# (!) Also manually put discard in the fstab/crypttab for the SSD
sed --in-place 's/\(GRUB_CMDLINE_LINUX_DEFAULT\)="\(.*\)"/\1="\2 rootfstype=ext4"/g' /etc/default/grub
sudo update-grub


###############################################################################
# Fix wifi

#Apparently, there's a problem with 11n since wireless works fine with the following:
#rmmod iwlwifi ; modprobe iwlwifi 11n_disable=1
#So, permanently disable it: 
sudo tee -a /etc/modprobe.d/51-disable-6235-11n.conf << EOF
options iwlwifi 11n_disable=1
EOF

###############################################################################
# External mic

#echo "options snd-hda-intel model=laptop-dmic" | sudo tee -a /etc/modprobe.d/alsa-base.conf
#sudo alsa force-reload

###############################################################################
# Fix backlight
# See https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder

sudo tee -a /usr/share/X11/xorg.conf.d/51-backlight.conf << EOF
Section "Device"
	Identifier "Card0"
	Driver "intel"
	Option "Backlight" "/sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight"
EndSection
EOF
