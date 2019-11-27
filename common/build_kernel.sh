#!/bin/sh
source ./.config
KERNEL_DIR=build/kernel_$BSP_VERSION
echo $YOCTO_KERNEL_DIR
echo $KERNEL_DIR
if [[ -d $YOCTO_KERNEL_DIR ]] && [[ ! -d $KERNEL_DIR ]];then
    mkdir $KERNEL_DIR -p
fi
    
cp $YOCTO_KERNEL_DIR/* $KERNEL_DIR/ -rfd
cp resource/kernel_$BSP_VERSION/* $KERNEL_DIR/ -rfd

pushd $KERNEL_DIR
source_env
ARCH=arm make imx_v7_tqe9v3_defconfig
ARCH=arm make -j 4 
popd
if [ ! -d build/image ];then
    mkdir build/image -p
fi
cp $KERNEL_DIR/arch/arm/boot/zImage build/image/
cp $KERNEL_DIR/arch/arm/boot/dts/imx6q-sabresd.dtb build/image/
