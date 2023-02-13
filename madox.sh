#!/bin/bash
declare -u choice
declare -i n
echo -n "Enter the name: "
read name
name=$(echo $name | sed "s/ /%20/g")
echo -n "anime or manga[a/m]: "
read choice
declare c
if [ "$choice" == "A" ]
then
        c="anime"
elif [ "$choice" == "M" ]
then
        c="manga"
else
        echo wrong input
        exit 5
fi
res=$(curl -s "https://myanimelist.net/search/prefix.json?type=$c&keyword=$name")
echo $res | jq '.categories[] | .items[] | .name, .payload.media_type' | sed -E -e "s/^[{|}]//g" -e "s/[\"]//g" -e "s/[\,]$//g" | awk '{getline b;printf("%s (%s)\n",$0,b)}' | awk '{print "[" NR-0 "] " $0}'
idarray=( $(echo $res | jq '.categories[] | .items[] | .id') )
echo -n "Enter choice:"
read n
echo ${idarray[@]}
echo $res | jq --argjson a "${idarray[ (($n-1)) ]}" '.categories[] | .items[] | select(.id == $a)'
