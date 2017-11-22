#!/bin/bash

if grep '# Added Flag' /etc/security/limits.conf;
then
    true
else
    cat >> /etc/security/limits.conf << EOF

# Added Flag
*               soft    nproc           65535
*               hard    nproc           65535
root            soft    nproc           65535
root            hard    nproc           65535
*               soft    nofile          100001
*               hard    nofile          100001
root            soft    nofile          100001
root            hard    nofile          100001
EOF
fi
