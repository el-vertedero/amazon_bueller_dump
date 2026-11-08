#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:7276544:fb9b35b1d89a266cde34ccf49cb1cb9612e25325; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:6623232:7ba647bd5556d2c0d1b7aafdc9ef27ea18056d25 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery fb9b35b1d89a266cde34ccf49cb1cb9612e25325 7276544 7ba647bd5556d2c0d1b7aafdc9ef27ea18056d25:/system/recovery-from-boot.p && echo "
Installing new recovery image: succeeded
" >> /cache/recovery/log || echo "
Installing new recovery image: failed
" >> /cache/recovery/log
else
  log -t recovery "Recovery image already installed"
fi
