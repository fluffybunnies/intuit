intuit
======

Created to figure out why mysql was mysteriously dying.


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

