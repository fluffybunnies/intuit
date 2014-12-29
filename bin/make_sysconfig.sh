#!/bin/bash
# @todo: maybe also... lsof -nc mysqld | grep log

. ./configure.sh
. ./lib/util.sh

mysqlConn=`buildMysqlConn "$mysqlHost" "$mysqlUser" "$mysqlPass"`

res=`echo 'show global variables where Variable_name in ("general_log_file","log_error","slow_query_log_file")' | $mysqlConn`

if [ "$res" == "" ]; then
	echo "failed to fetch mysql variables. stopping."
	if [ "$mysqlLogFiles" == "" ]; then
		echo 'export mysqlLogFiles=()' > ./config.sys.sh
	fi
	exit 1
fi

i=0
IFS_=$IFS
IFS=$'\n'
for line in $res; do
	IFS=$'\t' read -a var <<< "$line"
	if [ "${var[1]}" != "" ] && [ "${var[0]}" != "Variable_name" ]; then
		echo "found config: ${var[0]}=${var[1]}"
		logs[$i]="'${var[1]}'"
		i=$[i+1]
	fi
done
IFS=$IFS_

echo 'export mysqlLogFiles=('${logs[@]}')' > ./config.sys.sh
