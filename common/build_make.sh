#!/bin/bash
source .config
cp resource/imx-yocto-bsp-L$BSP_VERSION/* $YOCTO_DIR/ -rfd
pushd $YOCTO_DIR
if [ ! -d build_x11 ];then
DISTRO=fsl-imx-x11 MACHINE=imx6qsabresd source fsl-setup-release.sh -b build_x11
else
source setup-environment build_x11
fi

cp $TOP_DIR/resource/imx-yocto-bsp-L$BSP_VERSION/build_x11 build_x11 -rfd

bitbake fsl-image-qt5
bitbake fsl-image-qt5 -c populate_sdk
if [ ! -d $TOP_DIR/build/image ];then
    mkdir $TOP_DIR/build/imake -p
fi
cp tmp/deploy/sdk/*-fsl-image-qt5-*.sh  $TOP_DIR/build/image/
cp tmp/deploy/images/imx6qsabresd/fsl-image-qt5-imx6qsabresd.ext4  $TOP_DIR/build/image/
#sudo tmp/deploy/sdk/fsl-imx-fb-glibc-x86_64-core-image-minimal-cortexa9hf-neon-toolchain-4.14-sumo.sh
popd #fsl-release-bsp
