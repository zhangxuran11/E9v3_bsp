#!/bin/sh
source ./.config

UBOOT_DIR=build/uboot_$BSP_VERSION
echo $UBOOT_DIR
echo $YOCTO_UBOOT_DIR
if [[ -d $YOCTO_UBOOT_DIR ]] && [[ ! -d $UBOOT_DIR ]];then
    mkdir $UBOOT_DIR -p
    cp $YOCTO_UBOOT_DIR/* $UBOOT_DIR/ -rfd
fi
#exit 0
if [ ! -d ${UBOOT_DIR}/board/embedsky/tqe9v3 ];then
    mkdir ${UBOOT_DIR}/board/embedsky/tqe9v3 -p
fi
#    cp ${UBOOT_DIR}/board/freescale/mx6sabresd/* ${UBOOT_DIR}/board/embedsky/tqe9v3/ -rfd
#    rm ${UBOOT_DIR}/board/embedsky/tqe9v3/mx6sabresd.c
cp resource/uboot_$BSP_VERSION/* $UBOOT_DIR/ -rfd
pushd $UBOOT_DIR
source_env

#make clean
ARCH=arm make tqe9v3_defconfig
ARCH=arm make -j 8

popd
if [ ! -d build/image ];then
    mkdir build/image -p
fi

cp $UBOOT_DIR/$UBOOT_IMX build/image/

