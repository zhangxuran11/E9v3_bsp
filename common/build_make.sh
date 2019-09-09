#!/bin/bash
source .config
pushd $YOCTO_DIR
if [ ! -d build_x11 ];then
DISTRO=fsl-imx-fb MACHINE=imx6qsabresd source fsl-setup-release.sh -b build_x11
else
source fsl-setup-release.sh -b build_x11
fi
bitbake core-image-minimal
popd #fsl-release-bsp
