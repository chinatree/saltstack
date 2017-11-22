#!/bin/bash

WEB_VRRP="192.168.2.10"

case "$1" in
start)
       ifconfig lo:0 $WEB_VRRP netmask 255.255.255.255 broadcast $WEB_VRRP
       /sbin/route add -host $WEB_VRRP dev lo:0
       echo "1" > /proc/sys/net/ipv4/conf/lo/arp_ignore
       echo "2" > /proc/sys/net/ipv4/conf/lo/arp_announce
       echo "1" > /proc/sys/net/ipv4/conf/all/arp_ignore
       echo "2" > /proc/sys/net/ipv4/conf/all/arp_announce
       sysctl -p >/dev/null 2>&1
       echo "RealServer Start OK"
       ;;

stop)
       ifconfig lo:0 down
       route del $WEB_VRRP > /dev/null 2>&1
       echo "0" > /proc/sys/net/ipv4/conf/lo/arp_ignore
       echo "0" > /proc/sys/net/ipv4/conf/lo/arp_announce
       echo "0" > /proc/sys/net/ipv4/conf/all/arp_ignore
       echo "0" > /proc/sys/net/ipv4/conf/all/arp_announce
       echo "RealServer Stoped"
       ;;

status)
       # Status of LVS-DR real server.
       islothere=`/sbin/ifconfig lo:0 | grep "$WEB_VRRP"`
       isrothere=`netstat -rn | grep "lo:0" | grep "$WEB_VRRP"`
       if [ ! "$islothere" -o ! "isrothere" ];then
           # Either the route or the lo:0 device
           # not found.
           echo "LVS-DR real server Stopped."
       else
           echo "LVS-DR Running."
       fi
       ;;
*)
       # Invalid entry.
       echo "Usage: $0 {start|status|stop}"
       exit 1
       ;;
esac

exit 0

