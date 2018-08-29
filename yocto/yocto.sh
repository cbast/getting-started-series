#!/bin/bash

sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping

git clone git://git.yoctoproject.org/poky -b rocko
git clone git://git.openembedded.org/meta-openembedded -b rocko
git clone git://git.yoctoproject.org/meta-raspberrypi -b rocko

sed -i 's/\(.*output = subprocess.check_output.*\)/\1 '"'"'--apparent-size'"'"',/' poky/meta/classes/image.bbclass

source poky/oe-init-build-env rpi-build

bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-multimedia
bitbake-layers add-layer ../meta-openembedded/meta-python
bitbake-layers add-layer ../meta-openembedded/meta-networking
bitbake-layers add-layer ../meta-raspberrypi

sed -i '/^MACHINE/i MACHINE ?= "raspberrypi3"' conf/local.conf

bitbake rpi-basic-image

bitbake rpi-basic-image -c populate_sdk

