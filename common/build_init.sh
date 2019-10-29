#!/bin/bash

if [ $# -lt 1 ];then
echo not fond config file
echo Useage:
echo "  ./build.sh init imx-yocto-L4.14.98_2.0.0_ga_defconfig"
exit 1
fi

source common/common.sh
cp common/$1 .config
source .config


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
which repo>/dev/null
if [ ! -f ~/bin/repo  -o  $? == 1 ];then
    cp component/repo  ~/bin/repo
    #curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
fi
repo 2> /dev/null
if [ $? == 0 ];then
    echo repo is invalid
    rm ~/bin/repo
    exit -1
fi
if [ ! -d $YOCTO_DIR ];then
    mkdir $YOCTO_DIR -p
fi
pushd $YOCTO_DIR
pwd
repo_init
repo sync

popd 
