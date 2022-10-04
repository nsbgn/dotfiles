#!/bin/sh
# Login manager daemon
# Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1010247
# Alpine: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/greetd
# Source: https://git.sr.ht/~kennylevinsen/greetd
set -eu

sudo apt install cargo libpam-dev
mkdir -p ~/.builds
cd ~/.builds
git clone https://git.sr.ht/~kennylevinsen/greetd
cd greetd

# Compile greetd and agreety.
cargo build --release
sudo cp target/release/{greetd,agreety} /usr/local/bin/
sudo cp greetd.service /etc/systemd/system/greetd.service

# Create the greeter user
sudo mkdir /etc/greetd
sudo useradd -M -G video greeter
sudo chmod -R go+r /etc/greetd/

# Look in the configuration file `/etc/greetd/config.toml` and edit as appropriate.
# When done, enable and start greetd
# cp config.toml /etc/greetd/config.toml
# systemctl enable --now greetd
