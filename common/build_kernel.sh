#!/bin/sh
source ./.config
KERNEL_DIR=build/kernel_$BSP_VERSION
YOCTO_KERNEL_DIR=$YOCTO_DIR/$BUILD_DIR/tmp/work/imx6qsabresd-poky-linux-gnueabi/linux-imx/4.14.98-r0/git
echo $YOCTO_KERNEL_DIR
echo $KERNEL_DIR
if [[ -d $YOCTO_KERNEL_DIR ]] && [[ ! -d $KERNEL_DIR ]];then
    mkdir $KERNEL_DIR -p
    cp $YOCTO_KERNEL_DIR/* $KERNEL_DIR/ -rfd
    cp resource/kernel_$BSP_VERSION/* $KERNEL_DIR/ -rfd
fi
pushd $KERNEL_DIR
source /opt/fsl-imx-fb/4.14-sumo/environment-setup-cortexa9hf-neon-poky-linux-gnueabi
ARCH=arm make imx_v7_defconfig
ARCH=arm make -j 4 
popd
if [ ! -d build/image ];then
    mkdir build/image -p
fi
cp $KERNEL_DIR/arch/arm/boot/zImage build/image/
cp $KERNEL_DIR/arch/arm/boot/dts/imx6q-sabresd.dtb build/image/
