#!/usr/bin/env bash

set -x
set -e

if [ ! -f "/etc/cron.d/docker-cron" ] ; then
    /cron-setup.sh
fi

# Start cron daemon
cron

exec tail -f $CRON_LOG
