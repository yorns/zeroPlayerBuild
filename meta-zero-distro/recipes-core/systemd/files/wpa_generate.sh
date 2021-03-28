#!/bin/bash
/usr/bin/wpa_generator
/bin/rm -f /run/startApEither
/bin/systemctl restart hostapd
/bin/systemctl restart wpa_supplicant

