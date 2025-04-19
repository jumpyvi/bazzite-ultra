#!/bin/bash

set -ouex pipefail

tee /etc/yum.repos.d/docker-ce.repo <<'EOF'
[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=https://download.docker.com/linux/fedora/$releasever/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
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
    foot
    nordvpn
    bridge-utils
    xhost
    cockpit
    sunshine
    containerd.io
    docker-buildx-plugin
    docker-ce
    docker-ce-cli
    docker-compose-plugin
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
