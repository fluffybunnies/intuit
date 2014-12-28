#!/bin/bash

defaultInterval=5

interval=$1
isNum='^[1-9]+$'
if ! [[ "$interval" =~ $isNum ]]; then
	echo "defaulting to interval of $defaultInterval minutes"
	interval=$defaultInterval
fi

if [ "`which realpath`" == "" ]; then
	realpath() {
		echo `cd "${1}";pwd`
	}
fi

__dirname=`dirname $0`
__dirname=`realpath $__dirname`

. $__dirname/util.sh

script="*/$interval * * * * $__dirname/inspect.sh"
echo "installing crontab: $script"
#crontab_add 'inspect.sh' $script
