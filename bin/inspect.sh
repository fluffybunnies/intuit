#!/bin/bash
# ./inspect.sh --fail M111


echo "START "`date`
cd `dirname $0`/..


i=1
for arg in "$@"; do
	i=$[i+1]
	if [ "$arg" == "--fail" ]; then
		testFailure=${!i}
		echo "Testing Failure: $testFailure"
	fi
done


# update sys config
./bin/make_sysconfig.sh
. ./lib/configure.sh
. ./lib/util.sh
mysqlConn=`buildMysqlConn "$mysqlHost" "$mysqlUser" "$mysqlPass"`


# init log entry
nl=$'\n'
runKey=`date`
echo "---------- BEGIN $runKey ----------$nl" >> $logFile

# make sure we've got enough environment in crontab
echo "PATH: $PATH" >> $logFile

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


# ERROR_M111
if [ "$testFailure" == "M111" ]; then
	mysqlConn="$mysqlConn --socket=/dev/null"
fi
out=`echo 'select 1' | $mysqlConn 2>&1`
check=`echo $out | grep -i "Can't connect to local MySQL server through socket"`
if [ "$check" != "" ]; then
	# this is the error we are looking for
	echo "!!! ERROR_M111 !!!" >> $logFile
	echo $out >> $logFile
	if [ "$errorHandler_M111" != "" ]; then
		echo "handle error: $errorHandler_M111..." >> $logFile
		eval $errorHandler_M111 >> $logFile 2>&1
	fi
fi


echo "---------- END $runKey ----------$nl" >> $logFile
echo "$nl$nl$nl" >> $logFile


echo "END "`date`
