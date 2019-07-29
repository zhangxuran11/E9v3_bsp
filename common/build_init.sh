#!/bin/bash
source common/common.sh

if [ ! -d doc ];then
    mkdir doc
fi

pushd doc
FILE=fsl_yocto-L4.1.15_2.0.0-ga.tar.gz
DIR=fsl_yocto-L4.1.15_2.0.0-ga
URL="https://cache.nxp.com/secured/assets/documents/en/supporting-information/fsl_yocto-L4.1.15_2.0.0-ga.tar.gz?__gda__=1564073659_eaab277e7a07ba8ff431ca590d8b104f&fileExt=.gz"
SHA256_VAL=14489086c4feb9585f3884821885ffca8a1e56b010aab5199c4ec0c7908690f5
check_and_get_source_package $FILE $URL $SHA256_VAL
check_and_unpackage_source $FILE $DIR
popd

sudo apt-get build-dep qemu 
sudo apt-get remove oss4-dev
sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
     xterm
sudo apt-get install make xsltproc docbook-utils fop dblatex xmlto

sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat libsdl1.2-dev

sudo apt-get install libsdl1.2-dev xterm sed cvs subversion coreutils texi2html \
    docbook-utils python-pysqlite2 help2man make gcc g++ desktop-file-utils \
    libgl1-mesa-dev libglu1-mesa-dev mercurial autoconf automake groff curl lzop asciidoc

sudo apt-get install u-boot-tools

if [ ! -d ~/bin ];then
    mkdir ~/bin
fi

export PATH=~/bin:$PATH
which repo
if [ ! -f ~/bin/repo  -o  $? == 1 ];then
    cp component/repo  ~/bin/repo
    #curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
fi
if [ ! -d fsl-release-bsp ];then
    mkdir fsl-release-bsp
fi

repo
if [ $? == 0 ];then
    echo repo is invalid
    rm ~/bin/repo
    exit -1
fi
pushd fsl-release-bsp
repo init -u git://git.freescale.com/imx/fsl-arm-yocto-bsp.git -b imx-4.1-krogoth
repo sync

popd #fsl-release-bsp
