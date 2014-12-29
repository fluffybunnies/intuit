
export logFile=/var/log/intuit.log
export interval=5
export tailLines=50

export mysqlHost=
export mysqlUser=
export mysqlPass=

export rotateMaxFiles=10

export errorHandler_M111="echo 'rebooting mysql...' && PATH=/sbin:$PATH && service mysql restart"
