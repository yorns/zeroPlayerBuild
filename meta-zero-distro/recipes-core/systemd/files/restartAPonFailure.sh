#!/bin/bash
WAITTIME=30  
SYSTEMD=$(which systemd)
RM=$(which rm)      
LN=$(which ln)         
TOUCH=$(which touch)   
GREP=$(which grep)     
WPACLI=$(which wpa_cli)
CUT=$(which cut)    
SLEEP=$(which sleep)                                 
                                                     
$SLEEP $WAITTIME                                     
ip=$($WPACLI status | $GREP ip_address | $CUT -c 12-)

if [ -n "$ip" ] 
then                                                 
  echo "an ip address is available all fine"
  exit 0       
else
  echo "no ip address available"                    
  $TOUCH /run/startApEither
  $SYSTEMD stop wpa_supplicant
  $RM -f /run/systemd/network/10-wireless.network
  $SYSTEMD daemon-reload
  $SYSTEMD restart systemd-networkd
  $SYSTEMD start hostapd   
fi


