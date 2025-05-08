#!/system/bin/sh

echo "[ThunderCharge] Boot started at $(date)" >> /data/local/tmp/thundercharge.log

chmod -R 755 /data/adb/modules/thundercharge
echo "[ThunderCharge] Permissions set." >> /data/local/tmp/thundercharge.log

. /data/adb/modules/thundercharge/common.sh

find_charger_path
apply_charging_limit
run_fixcharge