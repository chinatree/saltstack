#!/bin/bash

if grep '# Added Flag' /etc/sysctl.conf;
then
    true
else
    cat >> /etc/sysctl.conf << EOF

# Added Flag
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
vm.swappiness = 10
EOF
    /sbin/sysctl -p
fi
