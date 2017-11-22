{% set data = salt['pillar.get']('ntpdate') -%}
#!/bin/bash

log_path="/backup/logs"
test ! -d "${log_path}" && mkdir -p "${log_path}"

/usr/sbin/ntpdate {{ data['master_ip'] }}
if [ $? -ne 0 ];
then
    sleep 5
    /usr/sbin/ntpdate {{ data['slave_ip'] }}
    if [ $? -ne 0 ];
    then
        sleep 5
        /usr/sbin/ntpdate {{ data['master_ip'] }}
        if [ $? -eq 0 ];
        then
            echo "`date` ntpdate successful offset" > "${log_path}/ntp.log"
        else
            echo "`date` ntpdate failed"
        fi
    else
        echo "`date` ntpdate successfule offset" > "${log_path}/ntp.log"
    fi
else
    echo "`date` ntpdate successfule offset" > "${log_path}/ntp.log"
fi
