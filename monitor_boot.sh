#!/system/bin/sh
MODDIR=${0%/*}
. $MODDIR/common.sh

# Tunggu hingga sistem benar-benar selesai boot
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 5
done

sh "$MODDIR/charge.sh"