#!/bin/bash

#index_array=('davi' 'lucas' 3 4 5 6)

#index_array+=("Dish Washer")

#echo ${index_array[*]}

if [[ -z $1 ]]; then
    echo -e "\n[=> Parse HTML\n"
    echo "$0 http://site.com"
    exit
fi

target=$1
targetDomain=$(echo $target | sed 's/http:\/\///g' | sed 's/https:\/\///g' | sed 's/\///g')

html="/tmp/"$targetDomain".html"

echo -e "\n[*] Reading data..."
wget -q $target -O $html

echo -e "\n[*] Extracting URLs:\n"
cat $html | grep href | grep "\." | awk -F 'href' '{print $2}' | sed "s/=[\"']//g" | cut -d "'" -f 1 | cut -d '"' -f 1 | grep http | sort -u

echo -e "\n[*] Extracting Href Files:\n"
cat $html | grep href | grep "\." | awk -F 'href' '{print $2}' | sed "s/=[\"']//g" | cut -d "'" -f 1 | cut -d '"' -f 1 | grep -v http | sort -u

echo -e "\n[*] Extracting Src Files:\n"
cat $html | grep src | sed 's/>/\n/g' | awk -F 'src' '{print $2}' | sed "s/=['\"]//g" | cut -d "'" -f 1 | cut -d '"' -f 1 | sort -u 

rm $html
