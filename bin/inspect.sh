#!/bin/bash
# ./bin/inspect.sh M38


. ./configure.sh
. ./lib/util.sh

testFailure=$1
if [ "$testFailure" != "" ]; then
	echo "Testing Failure: $testFailure"
fi


# update sys config
./bin/make_sysconfig.sh

mysqlConn=`buildMysqlConn "$mysqlHost" "$mysqlUser" "$mysqlPass"`


# init log entry
nl=$'\n'
runKey=`date`
echo "---------- BEGIN $runKey ----------$nl" >> $logFile

# tail mysql logs
for mysqlLogFile in ${mysqlLogFiles[*]}; do
	echo "$mysqlLogFile:" >> $logFile
	tail -n$tailLines "$mysqlLogFile" >> $logFile 2>&1
	echo "$nl" >> $logFile
done

# ps
echo "ps aux | grep mysql:" >> $logFile
ps aux | grep mysql >> $logFile 2>&1
echo "$nl" >> $logFile

# mysql process list
echo "show full processlist:" >> $logFile
echo 'show full processlist' | $mysqlConn >> $logFile 2>&1
echo "$nl" >> $logFile

# innodb status
echo "show engine innodb status\G:" >> $logFile
echo 'show engine innodb status\G' | $mysqlConn >> $logFile 2>&1
echo "$nl" >> $logFile

# show profiles
echo "show profiles; show profile;" >> $logFile
echo 'show profiles; show profile;' | $mysqlConn >> $logFile 2>&1
echo "$nl" >> $logFile


# ERROR_M38
if [ "$testFailure" == "M38" ]; then
	mysqlConn="$mysqlConn --socket=/dev/null"
fi
out=`echo 'select 1' | $mysqlConn 2>&1`
check=`echo $out | grep -i "Can't connect to local MySQL server through socket"`
if [ "$check" != "" ]; then
	# this is the error we are looking for
	echo "!!! ERROR_M38 !!!" >> $logFile
	echo $out >> $logFile
	if [ "$errorHandler_M38" != "" ]; then
		echo "handle error: $errorHandler_M38..." >> $logFile
		eval $errorHandler_M38 >> $logFile 2>&1
	fi
fi


echo "---------- END $runKey ----------$nl" >> $logFile
echo "$nl$nl$nl" >> $logFile


