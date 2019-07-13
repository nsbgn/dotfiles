#!/bin/bash

###############################################################################
# Fix wifi

#Apparently, there's a problem with 11n since wireless works fine with the following:
#rmmod iwlwifi ; modprobe iwlwifi 11n_disable=1
#So, permanently disable it: 
echo "options iwlwifi 11n_disable=1" > /etc/modprobe.d/51-disable-6235-11n.conf


###############################################################################
# Fix backlight
# See https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder

tee -a /usr/share/X11/xorg.conf.d/51-backlight.conf << EOF
Section "Device"
	Identifier "Card0"
	Driver "intel"
	Option "Backlight" "/sys/devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight"
EndSection
EOF
