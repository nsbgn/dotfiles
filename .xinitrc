
if which VBoxClient; then
VBoxClient --clipboard
VBoxClient --vmsvga
fi

for F in siji dina; do xset +fp /usr/share/fonts/bitmap/$F; done
xset fp rehash
xset +fp ~/.fonts
xset r rate 300 45
xrdb $HOME/.Xresources

# Avoid slow startup of GTK apps. See /etc/X11/xinit/xinitrc
dbus-update-activation-environment --verbose --systemd --all

# setxkbmap -option compose:menu & # enable compose key
# unclutter -root -idle 2 & # hide mouse when not in use for two seconds
# redshift -m randr -x -l manual -O 5500K # -l 52:5 & # less blue light
lxpolkit & # policy kit
# dunst & # notification daemon
# urxvtd -q -f -o 2>&1 > /tmp/urxvtlog & # terminal daemon
lf -server & # file manager daemon

exec openbox
