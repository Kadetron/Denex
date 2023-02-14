#!/bin/bash
declare -u choice
declare -i n
echo -en "\e[96mEnter the name:\e[0m "
read name
name=$(echo $name | sed "s/ /%20/g")
echo -en "\e[96mAnime or manga[A/m]:\e[0m "
read choice ; echo
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
echo -e "\e[1;93m$(echo $res | jq -r '.categories[] | .items[] | .name+" ("+.payload.media_type+")"' | awk '{print "[" NR-0 "] " $0}')\e[0m"
idarray=( $(echo $res | jq --arg a "$c" '.categories[] | select(.type == $a) | .items[] | .id') )
echo -en "\n\e[96mEnter choice:\e[0m"
read n
echo -e "\n\e[33m$(echo $res | jq --argjson a "${idarray[ (($n-1)) ]}" '.categories[] | .items[] | select(.id == $a)' | sed -E -e "s<\{|\}|^ {2,4}|\"id\":.*|\"type\":.*|\"image_url\":.*|\"thumbnail_url\":.*|\"payload\":.*|\"es_score\":.*|,$|\"<<g" -e "/^$/d" -e "s/^name:/Name=>  \t/" -e "s/^url:/Url=>   \t/" -e "s/^media_type:/Media type=>\t/" -e "s/^start_year:/Start year=>\t/" -e "s/^aired:/Aired=>  \t/" -e "s/^published:/Published=>\t/" -e "s/^score:/Score=>  \t/" -e "s/^status:/Status=>\t/")\e[0m"
