#!/bin/bash

if [[ $BASH_ARGC != 2 ]]; then
    echo "$0 <wan> <lan>"

    echo  "<wan> is the network interface to external"
    echo  "<lan> is the network interface to internal"
    exit 1
else
    external=$1
    internal=$2
fi

# delete old configuration, if any
# Flush all the rules in filter and nat tables
iptables --flush
iptables --table nat --flush

# delete all chains that are not in default filter and a nat table, if any
iptables --delete-chain
iptables --table nat --delete-chain

# Set up IP Masquerading (NAT) (up-side)
iptables -t nat -A POSTROUTING -o $external -j MASQUERADE

# Set up IP FORWARDing(down-side)
iptables -A FORWARD -i $internal -j ACCEPT

sysctl net.ipv4.ip_forward=1
