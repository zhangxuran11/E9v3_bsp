#!/bin/sh
source ./.config
KERNEL_DIR=build/kernel_$BSP_VERSION
echo $YOCTO_KERNEL_DIR
echo $KERNEL_DIR
if [[ -d $YOCTO_KERNEL_DIR ]] && [[ ! -d $KERNEL_DIR ]];then
    mkdir $KERNEL_DIR -p
    cp $YOCTO_KERNEL_DIR/* $KERNEL_DIR/ -rfd
fi
    
cp resource/kernel_$BSP_VERSION/* $KERNEL_DIR/ -rfd

if [ ! -d build/image ];then
    mkdir build/image -p
fi

pushd $KERNEL_DIR
source_env
export ARCH=arm
make imx_v7_tqe9v3_defconfig
make -j 4 
make modules_install INSTALL_MOD_PATH=$TOP_DIR/build/image/kernel_modules/
popd
cp $KERNEL_DIR/arch/arm/boot/zImage build/image/
cp $KERNEL_DIR/arch/arm/boot/dts/imx6q-sabresd.dtb build/image/
