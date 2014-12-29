intuit
======

Created to figure out why mysql was mysteriously dying.


#### Install

```
npm install intuit && cd node_modules/intuit
```


#### Configure

Copy config.local.example.sh as config.local.sh
```
cp config.local.example.sh config.local.sh && vim config.local.sh
```


#### Start

```
npm start
```


#### Quickstart using defaults

```
npm install intuit && cd node_modules/intuit && cp config.local.example.sh config.local.sh && cat config.local.sh && npm start
```


#### To Do
- Rotate logs
- Better check for super user privileges

