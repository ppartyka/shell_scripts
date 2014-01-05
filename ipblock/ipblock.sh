#!/bin/sh

IPT=/sbin/iptables
PROG=`basename $0`

# Checks if the user is root
if [ "$USER" != "root" ]; then
	echo "Incorrect User"
	echo "Exiting..."
	exit 0
fi

# If there is no $1 input then script throws a usage function and exits with error
if [ -z $1 ]; then
	echo "Usage: $PROG <ip to block>"
	echo "Exiting..."
	exit 1
fi

# DROPS all traffic to and from specified IP
$IPT -I INPUT 1 -s $1 -j DROP
$IPT -I OUTPUT 1 -d $1 -j DROP
$IPT -I FORWARD 1 -s $1 -j DROP
$IPT -I FORWARD 1 -d $1 -j DROP

# Saves iptables rules so they will persist upon reboot
service iptables save
