#!/bin/sh
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
