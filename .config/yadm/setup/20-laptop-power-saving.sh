#!/bin/sh
# Tweaks for laptops
# <https://wiki.archlinux.org/title/Laptop_Mode_Tools>
# <https://wiki.archlinux.org/title/Powertop>
# <https://wiki.alpinelinux.org/wiki/Setting_up_a_laptop#Extending_battery_life>

# Power saving
sudo apt install acpi acpid acpitool cpufrequtils powertop tlp
# laptop-mode-tools ←⌿→ tlp

# Sensors
sudo apt install lm-sensors
sensors-detect
