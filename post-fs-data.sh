#!/system/bin/sh
LOGFILE="/data/local/tmp/thundercharge.log"

echo "[ThunderCharge] Boot started at $(date)" >> $LOGFILE

# Memberikan izin pada file yang dibutuhkan
chmod 755 /data/adb/modules/thundercharge/fixcharge
chmod 755 /data/adb/modules/thundercharge/common.sh
chmod 755 /data/adb/modules/thundercharge/charge.sh
chmod 755 /data/adb/modules/thundercharge/service.sh
chmod 755 /data/adb/modules/thundercharge/post-fs-data.sh

echo "[ThunderCharge] Permissions set." >> $LOGFILE

# Jalankan service.sh untuk mulai proses
sh /data/adb/modules/thundercharge/service.sh