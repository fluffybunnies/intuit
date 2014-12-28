
crontab_add(){
  search=$1
  line=$2
  if [ ! "$line" ]; then
    line=$search
  fi

  tmp=`mktemp`
  crontab -l | grep -v "$search" > $tmp
  echo "$line" >> $tmp
  crontab < $tmp 
  rm $tmp
}

crontab_remove(){
  search=$1
  tmp=`mktemp`
  crontab -l | grep -v "$search" > $tmp
  crontab < $tmp
  rm $tmp
}

buildMysqlConn(){
	host=$1
	user=$2
	pass=$3
	db=$4
	cmd='mysql'
	if [ "$host" != "" ]; then
		cmd=$cmd" --host '$host'"
	fi
	if [ "$user" != "" ]; then
		cmd=$cmd" --user '$user'"
	fi
	if [ "$pass" != "" ]; then
		cmd=$cmd" --password '$pass'"
	fi
	if [ "$db" != "" ]; then
		cmd=$cmd" $db"
	fi
	echo $cmd
}
