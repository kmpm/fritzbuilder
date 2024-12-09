#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive

APT_INSTALL="apt-get -qq install -y --no-install-recommends --no-install-suggests -o=Dpkg::Use-Pty=0"

if [ ! -f ]; then
    echo "deb http://deb.debian.org/debian bookworm-backports main" > /etc/apt/sources.list.d/bookworm-backports.list
fi

echo "Updating package list"
apt-get -qq update

echo "Installing dependencies"

${APT_INSTALL} \
    build-essential libgl1-mesa-dev \
    ninja-build generate-ninja \
    gperf bison flex libcups2-dev \
    libatspi2.0-dev \
    libdbus-1-dev \
    libclang-dev \
    libfontconfig-dev \
    libfontconfig1-dev \
    libfreetype-dev \
    libfreetype6-dev \
    libgl4es-dev \
    libglib2.0-dev \
    libice-dev \
    libicu-dev \
    libinput-dev \
    libts-dev \
    libjpeg-dev \
    libpng-dev \
    libsm-dev \
    libssl-dev \
    libsqlite3-dev \
    libx11-dev \
    libx11-xcb-dev \
    libxcb-cursor-dev \
    libxcb-icccm4-dev \
    libxcb-image0-dev \
    libxcb-keysyms1-dev \
    libxcb-render-util0-dev \
    libxcb-render0-dev \
    libxcb-randr0-dev \
    libxcb-shape0-dev \
    libxcb-sync-dev \
    libxcb-shm0-dev \
    libxcb-util-dev \
    libxcb-xfixes0-dev \
    libxcb-xkb-dev \
    libxcb1-dev \
    libxext-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libdrm-dev \
    libgl-image-display-dev \
    libgl1-mesa-dev \
    libglbinding-dev \
    libinput-dev libts-dev \
    libvulkan-dev \
    libvulkan-dev vulkan-tools
    
    # libgl4es-dev 

# cleanup
apt-get clean \
&& rm -rf /var/lib/apt/lists/*
   