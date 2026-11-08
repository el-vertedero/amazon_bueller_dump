#!/system/bin/sh

export DEV_FLAGS_USB_MODE_PERIPHERAL=0x1

devflagsfile="/proc/idme/dev_flags"
fosflagsfile="/proc/idme/fos_flags"

if [ -f $fosflagsfile ]; then
    export FOSFLAGS=`cat $fosflagsfile`
    log -p i -t metrics.idmeflags "kernel:idme:fosflags=$FOSFLAGS;DV;1:NR"
fi

if [ -f $devflagsfile ]; then
    export DEVFLAGS=`cat $devflagsfile`
    if [ $(( $DEV_FLAGS_USB_MODE_PERIPHERAL & 0x$DEVFLAGS )) != 0 ]; then
        setprop sys.usb.debugging y
    fi
    log -p i -t metrics.idmeflags "kernel:idme:devflags=$DEVFLAGS;DV;1:NR"
fi
