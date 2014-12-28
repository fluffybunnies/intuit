
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

