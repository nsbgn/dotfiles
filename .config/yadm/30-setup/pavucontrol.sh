#!/bin/sh
# https://askubuntu.com/questions/879037/pavucontrol-stuck-at-establishing-connection-to-pulseaudio-please-wait

pulseaudio --check
pulseaudio -D
