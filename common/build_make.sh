#!/bin/bash
source .config
pushd $YOCTO_DIR
if [ ! -d build_x11 ];then
DISTRO=fsl-imx-x11 MACHINE=imx6qsabresd source fsl-setup-release.sh -b build_x11
else
source fsl-setup-release.sh -b build_x11
fi
#bitbake core-image-minimal -c populate_sdk 
#bitbake core-image-minimal
bitbake fsl-image-qt5-validation-imx
if [ ! -d $TOP_DIR/build/image ];then
    mkdir $TOP_DIR/build/imake -p
fi
cp tmp/deploy/images/imx6qsabresd/core-image-minimal-imx6qsabresd.ext4  $TOP_DIR/build/image/
#sudo tmp/deploy/sdk/fsl-imx-fb-glibc-x86_64-core-image-minimal-cortexa9hf-neon-toolchain-4.14-sumo.sh
popd #fsl-release-bsp
