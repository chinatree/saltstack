#!/bin/bash

test $# -ne 1 && echo "Please input hostname para!" && exit 2
hostname="$1"

echo "${hostname}" > /etc/hostname
sed -i '/127.0.1.1/c 127.0.1.1\t'"${hostname}"'' /etc/hosts
hostname "${hostname}"
