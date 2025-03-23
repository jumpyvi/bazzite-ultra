#!/bin/bash

set -ouex pipefail

tee /etc/yum.repos.d/ghostty.repo <<'EOF'
[copr:copr.fedorainfracloud.org:pgdev:ghostty]
name=Copr repo for Ghostty owned by pgdev
baseurl=https://download.copr.fedorainfracloud.org/results/pgdev/ghostty/fedora-$releasever-$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/pgdev/ghostty/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOF

tee /etc/yum.repos.d/nordvpn.repo <<'EOF'
[nordvpn]
name=nordvpn
enabled=1
gpgcheck=0
baseurl=https://repo.nordvpn.com/yum/nordvpn/centos/x86_64
EOF


RELEASE="$(rpm -E %fedora)"

PACKAGES_TO_INSTALL=(
    ghostty
    nordvpn
    bridge-utils
    xhost
)


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install "${PACKAGES_TO_INSTALL[@]}"

rpm-ostree override remove \
    nvtop tailscale



### Add brew
# curl -fsSL "https://raw.githubusercontent.com/ublue-os/bluefin/refs/heads/main/build_files/base/10-brew.sh" | bash
