#!/bin/bash
# Tweaks for laptops

# https://wiki.archlinux.org/title/Laptop_Mode_Tools
# https://wiki.archlinux.org/title/Powertop

# Power saving
sudo apt install acpi acpid acpitool laptop-mode-tools cpufrequtils powertop

# Sensors
sudo apt install lm-sensors
sensors-detect
