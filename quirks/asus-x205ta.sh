#!/bin/bash

# General: https://ubuntuforums.org/showthread.php?t=2379657&p=13719125#post13719125
# Ubuntu: https://ubuntuforums.org/showthread.php?t=2254322&page=178&p=13681047#post13681047

# Add kernel parameter to prevent crashes
sed --in-place 's/\(GRUB_CMDLINE_LINUX_DEFAULT\)="\(.*\)"/\1="\2 intel_idle.max_cstate=1 button.lid_init_state=open"/g' /etc/default/grub
sudo update-grub

# relative_sleep_states=1 used to be (?) necessary to get suspension working

##############################################################################
# Wifi

# probably not necessary, but to be sure the EFI variables are properly exposed to userspace
sudo modprobe efivarfs
sudo mount -t efivarfs efivarfs /sys/firmware/efi/efivars

# then copy the file that starts with nvram to /lib/firmware/brcm
sudo cp -a /sys/firmware/efi/efivars/nvram* /lib/firmware/brcm/brcmfmac43340-sdio.txt

# Alternatively use https://raw.githubusercontent.com/harryharryharry/x205ta-iso2usb-files/master/brcmfmac43340-sdio.txt

# and reload the brcmfmac module
sudo rmmod brcmfmac
sudo modprobe brcmfmac

##############################################################################
# Bluetooth

wget https://raw.githubusercontent.com/harryharryharry/x205ta-iso2usb-files/master/BCM43341B0.hcd
read -p "Are you sure you want to install BCM43341B0.hcd? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    sudo cp BCM43341B0.hcd /lib/firmware/brcm/
fi

sudo tee /etc/systemd/system/btattach.service << EOF
[Unit]
Description=Btattach

[Service]
Type=simple
ExecStart=/usr/bin/btattach --bredr /dev/ttyS1 -P bcm
ExecStop=/usr/bin/killall btattach

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl restart btattach
sudo systemctl restart bluetooth
sudo systemctl status btattach
sudo systemctl restart bluetooth
sudo systemctl enable btattach
sudo systemctl enable bluetooth

##############################################################################
# Sound
# Also check out `pactl` for setting the correct sink by default

sudo apt install firmware-intel-sound intel-microcode

sudo tee /etc/modprobe.d/50-x205ta.conf << EOF
#this quirk is needed to get headphones support in kernels >=4.13
options snd_soc_rt5645 quirk=0x31

#module snd_hdmi_lpe_audio breaks sound
blacklist snd_hdmi_lpe_audio

#module btsdio breaks wifi on suspend/resume
blacklist btsdio 
EOF

wget https://raw.githubusercontent.com/plbossart/UCM/master/chtrt5645/HiFi.conf
read -p "Are you sure you want to install HiFi.conf? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    sudo cp HiFi.conf /usr/share/alsa/ucm/chtrt5645/
fi


##############################################################################
# Solve conflict between sdhci-acpi and brcmfmac
# No longer necessary?
# See https://bugzilla.kernel.org/show_bug.cgi?id=88061

#sudo apt install sysfsutils
#sudo tee -a /etc/sysfs.conf << EOF
## Disable SDHCI-ACPI for Wireless, otherwise WLAN doesn't work
#bus/platform/drivers/sdhci-acpi/INT33BB:00/power/control = on
#EOF
