#!/bin/bash

if [ "`which realpath`" == "" ]; then
	realpath() {
		echo `cd "${1}";pwd`
	}
fi

__dirname=`dirname $0`
__dirname=`realpath $__dirname`
cd $__dirname
export __dirname=$__dirname

. ./configure.sh
. ./lib/util.sh

if [ -f "./bin/$1" ]; then
	. "./bin/$1"
elif [ -f "./bin/$1.sh" ]; then
	. "./bin/$1.sh"
else
	echo "invalid script"
	ls ./bin
fi
