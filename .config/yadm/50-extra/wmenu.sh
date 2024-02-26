# Debian: https://packages.debian.org/trixie/wmenu

cd ~/.builds
git clone https://git.sr.ht/~adnano/wmenu
cd wmenu
meson build
ninja -C build
sudo ninja -C build install
