#!/bin/sh
source ./.config
UBOOT_DIR=build/uboot_$BSP_VERSION
YOCTO_UBOOT_DIR=$YOCTO_DIR/$BUILD_DIR/tmp/work/imx6qsabresd-poky-linux-gnueabi/u-boot-imx/2018.03-r0/git
echo $YOCTO_UBOOT_DIR
echo $UBOOT_DIR
if [[ -d $YOCTO_UBOOT_DIR ]] && [[ ! -d $UBOOT_DIR ]];then
    mkdir $UBOOT_DIR -p
    cp $YOCTO_UBOOT_DIR/* $UBOOT_DIR/ -rfd
fi
if [ ! -d ${UBOOT_DIR}/board/embedsky/tqe9v3 ];then
    mkdir ${UBOOT_DIR}/board/embedsky/tqe9v3 -p
    cp ${UBOOT_DIR}/board/freescale/mx6sabresd/* ${UBOOT_DIR}/board/embedsky/tqe9v3/ -rfd
    rm ${UBOOT_DIR}/board/embedsky/tqe9v3/mx6sabresd.c
    cp resource/uboot_$BSP_VERSION/* $UBOOT_DIR/ -rfd
fi


