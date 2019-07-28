#!/bin/bash
pushd fsl-release-bsp

DISTRO=fsl-imx-x11 MACHINE=imx6qsabresd source fsl-setup-release.sh -b build_x11
bitbake fsl-image-qt5
popd #fsl-release-bsp
