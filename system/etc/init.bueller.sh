#!/system/bin/sh

#
# log error if persist is not available
#
if [ ! -d /persist/data ]
then
  log "Persist is not available"
  exit 0
fi

mkdir -p /persist/data/macaddr
/system/bin/chmod 777 /persist/data/macaddr
/system/bin/chown -R system:system /persist/data/macaddr

#
# get the wifi MAC address from /proc/idme/mac_addr
#
MAC_STRING=`cat /proc/idme/mac_addr`
mac_oui=${MAC_STRING:0:6}

DEBUG=false
if [ $DEBUG == true ]
then
  log "Set WIFI MAC address:" $MAC_STRING
else
  log "Set WIFI MAC address:" $mac_oui
fi

#
# format the wifi address string in the appropriate format:
# echo -e \\xE0\\xCB\\x1D\\xA3\\x06\\xF2 > /system/etc/firmware/ath6k/AR6004/hw1.2/softmac.bin
#
mac1=${MAC_STRING:0:2}
mac2=${MAC_STRING:2:2}
mac3=${MAC_STRING:4:2}
mac4=${MAC_STRING:6:2}
mac5=${MAC_STRING:8:2}
mac6=${MAC_STRING:10:2}
wifi_addr_str="\\x${mac1}\\x${mac2}\\x${mac3}\\x${mac4}\\x${mac5}\\x${mac6}"
#
# write the mac address to the file: softmac.bin  
#
echo -e "$wifi_addr_str" > /persist/data/macaddr/softmac.bin
/system/bin/chmod 664 /persist/data/macaddr/softmac.bin
if [ ! -f /persist/data/macaddr/softmac.bin ]
then
  log "Unable to create wifi mac file"
fi

#
# Setting the BT mac address file 
#
MAC_STRING=`cat /proc/idme/bt_mac_addr`
log "Set BT MAC address:" $MAC_STRING
mac1=${MAC_STRING:0:2}
mac2=${MAC_STRING:2:2}
mac3=${MAC_STRING:4:2}
mac4=${MAC_STRING:6:2}
mac5=${MAC_STRING:8:2}
mac6=${MAC_STRING:10:2}
bt_addr_str="${mac1}:${mac2}:${mac3}:${mac4}:${mac5}:${mac6}"
echo "$bt_addr_str" > /persist/data/macaddr/ar3kbdaddr.pst
/system/bin/chmod 664 /persist/data/macaddr/ar3kbdaddr.pst
if [ ! -f /persist/data/macaddr/ar3kbdaddr.pst ]
then
  log "Unable to create bt mac file"
fi
