
# load
. ./config.sh
#defaultInterval=$interval
if [ -f ./config.local.sh ]; then
	. ./config.local.sh
fi
if [ -f ./config.sys.sh ]; then
	. ./config.sys.sh
fi


# validate
#isNum='^[1-9]+$'
#if ! [[ "$interval" =~ $isNum ]]; then
#	echo "using default interval: $defaultInterval"
#	interval=$defaultInterval
#fi
