#!/bin/sh

IPT=/sbin/iptables
PROG=`basename $0`

if [ "$USER" != "root" ]; then
	echo "Incorrect User"
	echo "Exiting..."
	exit 0
fi

if [ -z $1 ]; then
	echo "Usage: $PROG <ip to block>"
	echo "Exiting..."
	exit 1
fi

$IPT -I INPUT 1 -s $1 -j DROP
$IPT -I OUTPUT 1 -d $1 -j DROP
$IPT -I FORWARD 1 -s $1 -j DROP
$IPT -I FORWARD 1 -d $1 -j DROP

service iptables save
