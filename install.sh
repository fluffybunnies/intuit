#!/bin/bash

inspectEvery=5

if [ "`which realpath`" == "" ]; then
	realpath() {
		echo `cd "${1}";pwd`
	}
fi

__dirname=`dirname $0`
__dirname=`realpath $__dirname`

. $__dirname/util.sh

script="*/$inspectEvery * * * * $__dirname/inspect.sh"
echo "installing crontab: $script"
crontab_add 'inspect.sh' $script
