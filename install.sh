#!/bin/bash


if [ "`which realpath`" == "" ]; then
	realpath() {
		echo `cd "${1}";pwd`
	}
fi


__dirname=`dirname $0`
__dirname=`realpath $__dirname`


. $__dirname/configure.sh
. $__dirname/util.sh


# install
script="*/$interval * * * * $__dirname/inspect.sh"
echo "installing crontab: $script"
#crontab_add 'inspect.sh' $script
