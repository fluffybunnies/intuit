#!/bin/bash

. ./configure.sh
. ./util.sh

mysqlConn=`buildMysqlConn "$mysqlHost" "$mysqlUser" "$mysqlPass"`

echo $mysqlConn
