
# load
. ./config.sh
defaultInterval=$interval
if [ -f ./config.local.sh ]; then
	. ./config.local.sh
fi


# validate
isNum='^[1-9]+$'
if ! [[ "$interval" =~ $isNum ]]; then
	echo "defaulting to interval of $defaultInterval minutes"
	interval=$defaultInterval
fi
