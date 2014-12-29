#!/bin/bash

. ./configure.sh
. ./util.sh


testFailure=$1
if [ "$testFailure" != "" ]; then
	echo "Testing Failure: $testFailure"
fi


# update sys config
./make_sysconfig.sh

mysqlConn=`buildMysqlConn "$mysqlHost" "$mysqlUser" "$mysqlPass"`


# init log entry
nl=$'\n'
echo "---------- "`date`" ----------$nl" >> $logFile

# tail mysql logs
for mysqlLogFile in ${mysqlLogFiles[*]}; do
	echo "$mysqlLogFile:" >> $logFile
	tail -n$tailLines "$mysqlLogFile" >> $logFile 2>&1
	echo "$nl" >> $logFile
done

# mysql process list
echo "show full processlist:" >> $logFile
echo 'show full processlist' | $mysqlConn >> $logFile 2>&1
echo "$nl" >> $logFile


#echo $mysqlConn
mysqlConn="$mysqlConn --socket=/dev/null"


out=`echo 'select 1' | $mysqlConn 2>&1`
check=`echo $out | grep -i "Can't connect to local MySQL server through socket"`
if [ "$check" != "" ] || [ "$testFailure" == "M38" ]; then
	# this is the error we are looking for
	echo "!!! ERROR_M38 !!!" >> $logFile
	echo $out >> $logFile
	if [ "$errorHandler_M38" != "" ]; then
		echo "handle error: $errorHandler_M38..." >> $logFile
		eval $errorHandler_M38 >> $logFile 2>&1
	fi
fi


echo "$nl$nl$nl" >> $logFile


