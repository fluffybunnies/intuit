
# load
. ./config/config.sh
defaultInterval=$interval
defaultTailLines=$tailLines
if [ -f ./config/config.local.sh ]; then
	. ./config/config.local.sh
fi
if [ -f ./config/config.sys.sh ]; then
	. ./config/config.sys.sh
fi


# validate
positiveInt='^[1-9][0-9]*$'
if ! [[ "$interval" =~ $positiveInt ]]; then
	echo "using default interval: $defaultInterval"
	interval=$defaultInterval
fi
if ! [[ "$tailLines" =~ $positiveInt ]]; then
	echo "using default tailLines: $defaultTailLines"
	tailLines=$defaultTailLines
fi
