#!/bin/bash
declare -u choice
declare -i n
echo -n "anime or manga[a/m]: "
read choice
echo $choice
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
echo $c
#cat 1st.txt | jq '.categories[] | select(.type == "manga") | .items[] | {name:.name, media_type:.payload.media_type}'
#curl 'https://myanimelist.net/search/prefix.json?type=all&keyword=solo%leveling' | jq --arg a "$c" '.categories[] | select(.type==$a) | .items[] | {name:.name,media_type:.payload.media_type}'
cat 1st.txt | jq --arg a "$c" '.categories[] | select(.type==$a) | .items[] | {name:.name,media_type:.payload.media_type}'
idarray=( $(cat 1st.txt | jq --arg a "$c" '.categories[] | select(.type == $a) | .items[] | .id') )
echo ${#idarray[@]}
echo -n "Enter choice:"
read n
echo ${idarray[@]}
cat 1st.txt | jq --argjson a "${idarray[ (($n-1)) ]}" --arg s "$c" '.categories[] | select(.type == $s) | .items[] | select(.id == $a)'
