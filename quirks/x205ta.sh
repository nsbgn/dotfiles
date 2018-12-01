#!/bin/bash

# Install kernel. Don't forget to boot with intel_idle.max_cstate=1 if not running a patched kernel
sudo apt install -t stretch-backports "linux-image-4.18.0-0.bpo.1-amd64"

# Add kernel parameter to prevent crashes
sed --in-place 's/\(GRUB_CMDLINE_LINUX_DEFAULT\)="\(.*\)"/\1="\2 intel_idle.max_cstate=1"/g' /etc/default/grub
update-grub

# A micro SD card holds my music, since space is limited
sudo tee -a /etc/fstab << EOF
UUID=0b53ded4-868d-4876-853e-6539a6aac5ba /home/niels/data/music ext2 defaults,noatime,ro,nofail 0 0
EOF

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

