#!/bin/sh

sudo apt install -y greetd
sudo mkdir /etc/greetd
sudo tee /etc/greetd/config.toml <<EOF
[terminal]
vt = 1

[default_session]
command = "agreety --cmd /bin/bash"
user = "greeter"

[initial_session]
command = "wl sway"
user = "$USER"
EOF

sudo tee /etc/greetd/environments <<EOF
wl sway
wl wayfire
wl phosh
wl cage foot
bash
EOF
