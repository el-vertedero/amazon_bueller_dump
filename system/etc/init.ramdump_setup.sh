#!/system/bin/sh

PATH=/sbin:/system/sbin:/system/bin:/system/xbin
BUILD_TYPE=`grep ro.build.type /system/build.prop`

# mount parition and enable ramdump if ramdump cookie exists
if test -h /dev/block/platform/msm_sdcc.1/by-name/ramdump; then

    # mount ramdump partition
    mount -t vfat -rw -o umask=7003,uid=1000,gid=1000 /dev/block/platform/msm_sdcc.1/by-name/ramdump /mnt/ramdump

    # enable ramdump for all builds in cookie exits
    if test -f /mnt/ramdump/rdcookie.txt; then
        echo 1 > /sys/module/restart/parameters/download_mode
    fi
fi
