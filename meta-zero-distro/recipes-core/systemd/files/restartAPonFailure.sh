#!/bin/bash
WAITTIME=30  
SYSTEMD=$(which systemctl)
RM=$(which rm)      
LN=$(which ln)         
TOUCH=$(which touch)   
GREP=$(which grep)     
WPACLI=$(which wpa_cli)
CUT=$(which cut)    
SLEEP=$(which sleep)                                 
IFCONFIG=$(which ifconfig)
AWK=$(which awk)
                                                     
$SLEEP $WAITTIME                                     
ip=$($IFCONFIG wlan0 | $AWK '/inet addr/{print substr($2,6)}')
# ip=$($WPACLI status | $GREP ip_address | $CUT -c 12-)

if [ -n "$ip" ] 
then                                                 
  echo "an ip address is available all fine"
  exit 0       
else
  echo "no ip address available - add start flag for accesspoint mode"                    
  $TOUCH /run/startApEither
  echo "stop wifi client mode"
  $SYSTEMD stop wpa_supplicant
  echo "remove wireless dhcp routing"
  $RM -f /run/systemd/network/10-wireless.network
  echo "restart systemd network"
  $SYSTEMD daemon-reload
  $SYSTEMD restart systemd-networkd
  echo "start accesspoint"
  $SYSTEMD start hostapd   
fi

