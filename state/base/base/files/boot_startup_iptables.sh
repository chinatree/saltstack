#!/bin/bash

if grep 'Start Load Iptables Rules' /etc/rc.local > /dev/null 2>&1;
then
    exit 0
else
    #echo -e "No /etc/iptables.save found."
    iptables-save  > /etc/iptables.save
    sed -i '/exit 0/d' /etc/rc.local
    cat >> /etc/rc.local << EOF

# Start Load Iptables Rules
/sbin/iptables-restore < /etc/iptables.save

EOF

    sed -i -e '/^$/d' -e '/# Start /{x;p;x}' /etc/rc.local
fi
