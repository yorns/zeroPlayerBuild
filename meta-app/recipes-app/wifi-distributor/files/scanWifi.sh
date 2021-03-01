#!/bin/bash
while :
do
  readarray  array < <(iw dev wlp2s0 scan ap-force | grep "SSID:" | cut -f2 -d: | cut -c2- | sort -u)                                           
  output="{ \"SsidMessage\" : ["
  addition=" "
  for (( i=0; i< ${#array[@]}; ++i )); do ssid=${array[$i]//$'\n'}; if [[ ! "$ssid" =~ .*"\x00".* ]]; then output="${output}${addition}\"$ssid\""; addition=", ";fi; done; output="$output ] }";
  echo "$output"               
  sender2 audioserver "$output"
  sleep 1.2 # 0.5
done

