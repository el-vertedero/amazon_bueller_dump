#!/system/bin/sh

echo "usb_mode_set: started arg:$1" > /dev/kmsg

if [ "$1" = "post-boot" ]; then
    /system/bin/setprop tmp.accept_usb_mode y
    echo "usb_mode_set: checking idme overriding" > /dev/kmsg
    idme_override=`/system/bin/getprop sys.usb.debugging`
    if [ "$idme_override" = "y" ]; then
        echo "usb_mode_set: peripheral mode (idme override)" > /dev/kmsg
        /system/bin/setprop persist.sys.usb.debugging y
        exit 0
    fi
    usb_debugging=`/system/bin/getprop persist.sys.usb.debugging`
    if [ "$usb_debugging" = "y" ]; then
        echo "usb_mode_set: peripheral mode" > /dev/kmsg
        echo peripheral > /sys/devices/platform/msm_otg/mode
    else
	echo "usb_mode_set: host mode" > /dev/kmsg
	echo host > /sys/devices/platform/msm_otg/mode
    fi
else
    ready=`/system/bin/getprop tmp.accept_usb_mode`

    if [ -z $ready ]; then
        echo "usb_mode_set: not ready" > /dev/kmsg
    else
        if [ "$1" = "peripheral" ]; then
            echo "usb_mode_set: peripheral mode" > /dev/kmsg
            echo peripheral > /sys/devices/platform/msm_otg/mode
        elif [ "$1" = "host" ]; then
	    echo "usb_mode_set: host mode" > /dev/kmsg
	    echo host > /sys/devices/platform/msm_otg/mode
        else
            echo "usb_mode_set: invalid argument" > /dev/kmsg
        fi
    fi
fi
