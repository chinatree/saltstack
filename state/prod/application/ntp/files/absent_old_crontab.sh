#!/bin/bash

if ! grep 'ntp.sh' /etc/crontab;
then
    exit 0
else
    sed -i '/ntp.sh/d' /etc/crontab
fi
