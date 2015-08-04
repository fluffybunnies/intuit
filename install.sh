#!/bin/bash

if [ "`which realpath`" == "" ]; then
	realpath() {
		echo `cd "${1}";pwd`
	}
fi

__dirname=`dirname $0`
__dirname=`realpath $__dirname`
cd $__dirname

. ./lib/configure.sh
. ./lib/util.sh

grants=`echo "show grants for current_user" | mysql -h$mysqlHost -u$mysqlUser -p$mysqlPass | grep -i 'grant all privileges on *.*'`
if [ "$grants" == "" ]; then
	echo $'\n'"!!! WARNING !!! Mysql user does not have super privileges and unable to monitor all processes."$'\n'
	currentUser=`echo 'select user(), current_user()' | mysql -h$mysqlHost -u$mysqlUser -p$mysqlPass`
	superUsers=`echo 'select GRANTEE from information_schema.user_privileges where privilege_type="SUPER"' | mysql -h$mysqlHost -u$mysqlUser -p$mysqlPass`
	echo "Super Users:"
	if [ "$superUsers" == "" ]; then
		echo "[None Found]"
	else
		echo "$superUsers"
	fi
	echo ""
fi

./bin/make_sysconfig.sh

cron="*/$interval * * * * $__dirname/bin/inspect.sh > /dev/null #intuitInspect"
echo "installing crontab: $cron"
crontab_add '#intuitInspect' "$cron"

# rotate log
cron="0 3 * * * $__dirname/bin/logrotate.sh $rotateMaxFiles '$logFile' > /dev/null #intuitRotateLog"
echo "installing crontab: $cron"
crontab_add '#intuitRotateLog' "$cron"
