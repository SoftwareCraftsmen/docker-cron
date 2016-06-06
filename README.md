# README

[![](https://badge.imagelayers.io/softwarecraftsmen/cron:latest.svg)](https://imagelayers.io/?images=softwarecraftsmen/cron:latest)

This implementation is based on cron
## Prepare a docker host

```sh
docker-machine create --driver virtualbox default <1>
docker-machine start default <2>
eval `docker-machine env default` <3>
```

1. Create a docker machine (once only)
2. Start the docker machine
3. Setup the docker client to use the docker-machine


## Build cron

```sh
docker build -t softwarecraftsmen/cron .
```


## Extend and run cron

The cron base container only provides the scaffolding for cron jobs. In order to implement a cron job it must be extended and a job schedule has to be added.

The demo folder is containing a sample ```Dockerfile``` and ```docker-compose``` script to demonstrate the use of the base image.

```sh
FROM softwarecraftsmen/cron
MAINTAINER Software Craftsmen GmbH und CoKG <office@software-craftsmen.at>
```


The base container has setup an ```ONBUILD``` trigger that requires the ```cron-setup.sh``` shell script to be present. 
It may contain any shell instruction sufficient to setup the cron scheduler.
The ONBUILD triggers will add the script and execute it to finalize the setup of cron.

```sh
#!/usr/bin/env bash
echo  "* * * * * root echo hello >> $CRON_LOG 2>&1" >> /etc/cron.d/docker-cron
chmod 0644 /etc/cron.d/docker-cron
```

To fire up the cron scheduler run the ```docker-compose``` script. 

```sh
docker-compose --project-name=docker-cron-demo up 
```