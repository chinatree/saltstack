#!/bin/bash

PARA_NUM="$#"

test "${PARA_NUM}" -ne 2 && echo "[ ERROR ] Please input device and mount_dir para!" && exit 2

device="$1"
mount_dir="$2"
#device_uuid="$(ls -l /dev/disk/by-uuid | grep -w "${device}" | grep -v grep | head -n 1 | awk '{print $(NF-2)}')"
device_uuid="$(blkid /dev/"${device}" | awk -F '"' '{print $2}')"

if [ -z "${device_uuid}" ];
then
    echo "[ ERROR ] Can't Find uuid for ${device}!"
    exit 255
fi

echo "    -" >> /tmp/ceph_osd.log
echo "      device: '${device}'" >> /tmp/ceph_osd.log
echo "      device_uuid: '${device_uuid}'" >> /tmp/ceph_osd.log
echo "      mount_dir: '${mount_dir}'" >> /tmp/ceph_osd.log

exit 0
