#!/bin/sh
# I'm not a big fan of Signal's approach here. Either Snap or Flatpak or a
# Debian/Ubuntu repository. Using OpenSUSE's build system for now.

wget https://download.opensuse.org/repositories/network:/im:/signal/Fedora_41/network:im:signal.repo
dnf config-manager addrepo --from-repofile=network:im:signal.repo
