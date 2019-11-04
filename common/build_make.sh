#!/bin/bash
source .config
pushd $YOCTO_DIR
if [ ! -d build_x11 ];then
DISTRO=fsl-imx-fb MACHINE=imx6qsabresd source fsl-setup-release.sh -b build_x11
else
source fsl-setup-release.sh -b build_x11
fi
DISTRO=fsl-imx-fb MACHINE=imx6qsabresd bitbake core-image-minimal -c populate_sdk 
bitbake core-image-minimal
sudo tmp/deploy/sdk/fsl-imx-fb-glibc-x86_64-core-image-minimal-cortexa9hf-neon-toolchain-4.14-sumo.sh
popd #fsl-release-bsp
