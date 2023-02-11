#!/bin/bash
i=1
cat 1st.txt | jq '.categories[] | select(.type=="anime") | .items[] | {name:.name, media_type:.payload.media_type}' | sed -E -e "s/^[{|}]//g" -e "s/[\"]//g" -e "s/[\,]$//g" -e "s/_/ /g" -Ee "s/^(  n.*)/$((i + 1))\1/g" -e "s/^(  m.*)/ &/g"
