#!/usr/bin/env bash

echo  "* * * * * root echo hello >> $CRON_LOG 2>&1" >> /etc/cron.d/docker-cron
chmod 0644 /etc/cron.d/docker-cron
