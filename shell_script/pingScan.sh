#!/bin/bash

scriptName="pingScan.sh"

if [ -z $1 ]
    then
        echo "
Usage:
 chmod +x $scriptName
 ./$scriptName network first_host=1 last_host=255 timeout=2
    
Example:
 ./$scriptName 10.0.0 10 200 1
        "
    exit
fi

network=$1
firstHost=$( [[ $2 ]] && echo $2 || echo 1 )
lastHost=$( [[ $3 ]] && echo $3 || echo 255 )
timeout=$( [[ $4 ]] && echo $4 || echo 2 )

if [ $(echo $network | rev | cut -c 1) == "." ]
    then 
        network=$(echo $network | rev | cut -c2- | rev)
fi

echo "
===================================
            ./$scriptName

Params:
- network=$network
- firstHost=$firstHost
- lastHost=$lastHost
- timeout=$timeout

===================================
"
echo -e "[+] Active Hosts:\n"

for host in $(seq $firstHost $lastHost)
    do
        ip="$network.$host"
        cmd=$(ping -c 1 -W $timeout $ip)

        if [[ $cmd =~ "64 bytes" ]]
            then
                echo $ip
        fi        
done
