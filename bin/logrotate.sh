#!/bin/bash
# ./bin/logrotate.sh 10 ./out/mylog.log ./out/anotherlog.log

maxFiles=$1

positiveInt='^[1-9][0-9]*$'
if ! [[ "$maxFiles" =~ $positiveInt ]]; then
	echo "invalid maxFiles arg"
	exit 1
fi

rotate(){
	logFile=$1
	maxFiles=$2
	for ((i=$maxFiles;i>=0;i--)); do
		[ $i == 0 ] && suf='' || suf=".$i"
		[ ! -f "$logFile$suf" ] && continue
		if [ $i == $maxFiles ]; then
			echo "rm $logFile$suf"
			rm "$logFile$suf"
			continue
		fi
		echo "$logFile$suf > $logFile."$[$i+1]
		mv "$logFile$suf" "$logFile."$[$i+1]
	done
}

n=0
for arg in "$@"; do
	n=$[n+1]
	[ $n == 1 ] && continue
	rotate $arg $maxFiles
done

