#!/usr/bin/env bash

# In order to use this script on Mac OSX, you need a working version of getopt.
# E.g. install through brew install gnu-getopt and add it to the PATH through export PATH=$(brew --prefix gnu-getopt)/bin:$PATH
#
#

# Turn on error handling to avoid snowballing into issues caused by failed commands
set -e
set -x

#
# Use COMPOSE_OPTIONS for customizing general docker-compose options
# e.g. export COMPOSE_OPTIONS="-f docker-compose.backuparchive.yml" for configuring the backup archive volume
#
COMPOSE_OPTIONS="-f docker-compose.yml $COMPOSE_OPTIONS"

function parseArguments() {
    args=$(getopt --options t: --longoptions tag:  -- "$@")
    if [ $? -ne 0 ];
    then
      exit 1
    fi

    eval set -- "$args";

    while true; do
        case $1 in
            -t|--tag)
                TAG="$2" ;
                shift 2;
                ;;

            --)
                shift;
                break ;;

            *) echo "Unimplemented option: $1" >&2; exit 1;;
        esac
    done
}

parseArguments "$@"

# Building backup image
docker build -t softwarecraftsmen/cron:${TAG:=latest} .

# Building containers
cd demo
docker-compose --project-name cron $COMPOSE_OPTIONS build
