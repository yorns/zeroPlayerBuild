#!/bin/bash
echo "generate wpa supplicant config"
/usr/bin/wpa_generator
/bin/sync
echo "remove temporal AP start flag"
/bin/rm -f /run/startApEither
echo "start hostapd (Wifi Accesspoint)"
/bin/systemctl restart hostapd
echo "start wpa_supplicant (Wifi Client)"
/bin/systemctl restart wpa_supplicant

