#!/bin/bash

PARA_NUM="$#"

test "${PARA_NUM}" -ne 4 && echo "[ ERROR ] Please input device and mount_dir para!" && exit 2

device="$1"
mount_dir="$2"
type="$3"
options="$4"
#device_uuid="$(ls -l /dev/disk/by-uuid | grep -w "${device}" | grep -v grep | head -n 1 | awk '{print $(NF-2)}')"
device_uuid="$(blkid /dev/"${device}" | awk -F '"' '{print $2}')"

if [ -z "${device_uuid}" ];
then
    echo "[ ERROR ] Can't Find uuid for ${device}!"
    exit 255
fi

if [ -z "${mount_dir}" ];
then
    echo "[ ERROR ] Please input mount_dir!"
    exit 255
fi

if grep  -w ''"${mount_dir}"'' /etc/fstab;
then
    echo "[ ERROR ] There have been other disk mount at ${mount_dir} directory, please choose other directory!"
    exit 255
fi

if grep 'UUID='"${device_uuid}"'' /etc/fstab;
then
    exit 0
else
    cat >> /etc/fstab << EOF
UUID=${device_uuid} ${mount_dir}                   ${type}    ${options}        0 0
EOF
fi
