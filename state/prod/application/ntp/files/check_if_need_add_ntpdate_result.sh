#!/bin/bash


N=$(egrep -Hi -R "UserParameter" /usr/local/services/zabbix/etc/*|egrep ntpdate.result |wc -l)
if [ $N -ge 1 ];then
    echo -e "already added"
else
    echo -e "Need add"
    echo -e "UserParameter=ntpdate.result,cat /backup/logs/ntp.log" >> /usr/local/services/zabbix/etc/zabbix_agentd.conf.d/topvdn.all.conf
    echo -e "added successfully. Please restart zabbix agentd."
fi
