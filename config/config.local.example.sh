
export logFile=/var/log/intuit.log
export interval=5
export tailLines=50

export mysqlHost=
export mysqlUser=
export mysqlPass=

export rotateMaxFiles=10

export errorHandler_M38="echo 'rebooting mysql...' && /etc/init.d/mysql restart"
