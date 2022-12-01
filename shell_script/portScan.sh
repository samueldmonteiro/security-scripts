#!/bin/bash

if [[ -z $3 ]]; then
    echo "Ex: sudo $0 192.168.12 1 1000"
    exit
fi

host=$1
initialRage=$2
finalRange=$3

sudo hping3 -S $host --scan "$initialRage-$finalRange" | grep -vi "not responding"
