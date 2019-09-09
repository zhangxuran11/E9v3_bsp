#!/bin/bash
if [ ! -f common/build_$1.sh ];then
echo "not fond $1 cmd."
exit 1
fi
common/build_$1.sh $2
