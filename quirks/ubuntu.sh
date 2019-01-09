#!/bin/bash

# This will update the kernel, which I need for the wifi drivers in combination
# with linux-firmware on 16.04 LTS.
sudo apt-get install --install-recommends linux-generic-hwe-16.04 xserver-xorg-hwe-16.04
