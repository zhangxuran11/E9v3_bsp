#!/bin/sh
source ./.config
KERNEL_DIR=build/kernel_$BSP_VERSION
YOCTO_KERNEL_DIR=$YOCTO_DIR/$BUILD_DIR/tmp/work/imx6qsabresd-poky-linux-gnueabi/linux-imx/4.14.98-r0/git
echo $YOCTO_KERNEL_DIR
echo $KERNEL_DIR
if [[ -d $YOCTO_KERNEL_DIR ]] && [[ ! -d $KERNEL_DIR ]];then
    mkdir $KERNEL_DIR -p
    cp $YOCTO_KERNEL_DIR/* $KERNEL_DIR/ -rfd
fi
make imx_v7_defconfig
make
exit 0
if [ ! -d ${KERNEL_DIR}/board/embedsky/tqe9v3 ];then
    mkdir ${KERNEL_DIR}/board/embedsky/tqe9v3 -p
    cp ${KERNEL_DIR}/board/freescale/mx6sabresd/* ${KERNEL_DIR}/board/embedsky/tqe9v3/ -rfd
    rm ${KERNEL_DIR}/board/embedsky/tqe9v3/mx6sabresd.c
    cp resource/uboot_$BSP_VERSION/* $KERNEL_DIR/ -rfd
fi
pushd $KERNEL_DIR
source /opt/fsl-imx-fb/4.14-sumo/environment-setup-cortexa9hf-neon-poky-linux-gnueabi
make clean
ARCH=arm make tqe9v3_defconfig
ARCH=arm make
popd
if [ ! -d build/image ];then
    mkdir build/image -p
fi
cp $KERNEL_DIR/u-boot-dtb.imx build/image/

