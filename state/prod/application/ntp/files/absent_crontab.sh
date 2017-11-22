#!/bin/bash

if ! grep '# Add ntpdate task plan' /etc/crontab;
then
    exit 0
else
    sed -i '/# Add ntpdate task plan/,+2d' /etc/crontab
fi
