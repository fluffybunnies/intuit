intuit
======


#### The problem

Mysql was mysteriously stopping. When I logged in to check on it, mysqld was down:
> mysqladmin: connect to server at 'localhost' failed
> error: 'Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (111)'
> Check that mysqld is running and that the socket: '/var/run/mysqld/mysqld.sock' exists!


#### What it do

Logs a history of information about the server's state leading up to the fault.

- Every n minutes a swath of system information is logged, including
	- Tail of log files nabbed from SHOW GLOBAL VARIABLES the last time mysql was working
	- Indications of hung queries via SHOW FULL PROCESSLIST
	- Memory and CPU usage via SHOW ENGINE INNODB
	- Timeline of mysqld's aliveness via ps aux | grep mysql
	- ...and more
- Logs are rotated and dropped according to configurable settings
- Option to band-aid the problem upon detection by running any custom script, defaults to
	```service mysql restart```


#### What it will do

Shed light on more problems across any *nix-based stack.


#### Install

```
npm install intuit && cd ./node_modules/intuit
```


#### Configure

Copy config.local.example.sh as config.local.sh
```
cp ./config/config.local.example.sh ./config/config.local.sh && vim ./config/config.local.sh
```


#### Start

```
npm start
```


#### Quickstart using defaults

```
npm install intuit && cd ./node_modules/intuit && cp ./config/config.local.example.sh ./config/config.local.sh && cat ./config/config.local.sh && npm start
```


#### To Do
- Better check for super user privileges
- CPU info

