#!/bin/bash

# Install the kernel source for L4T

function installPkg {
    apt-add-repository universe
    apt-get update
    apt-get install libncurses5-dev libncursesw5-dev qt5-default pkg-config -y
}

if [ $(dpkg-query -W -f='${Status}' qt5-default pkg-config 2>/dev/null | grep -o 'ok installed' | wc -l) -lt 2 ]; then
    installPkg
fi

cd /usr/src

if [ ! -f "source_release.tbz2" ]; then
    wget http://developer.download.nvidia.com/embedded/L4T/r28_Release_v1.0/BSP/source_release.tbz2
    tar -xvf source_release.tbz2 sources/kernel_src-tx2.tbz2
    tar -xvf sources/kernel_src-tx2.tbz2
fi

cd kernel/kernel-4.4

zcat /proc/config.gz > .config
make menuconfig
# make xconfig
