#!/bin/sh
# Wayland tiling window manager
# Alpine: https://pkgs.alpinelinux.org/package/edge/testing/x86_64/river
# Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1006593
set -e

cd ~/.builds
wget https://ziglang.org/download/0.9.1/zig-linux-x86_64-0.9.1.tar.xz
tar -xvf zig-linux-x86_64-0.9.1.tar.xz
export PATH=$PATH:$HOME/.builds/zig-linux-x86_64-0.9.1/
git clone https://github.com/riverwm/river
cd river
git submodule update --init
zig build -Drelease-safe --prefix ~/.local install
