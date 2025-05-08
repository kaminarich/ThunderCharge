#!/system/bin/sh

# Fungsi untuk menemukan path charger
find_charger_path() {
    charger_path=""

    for path in /sys/devices/platform/*/power_supply/*/input_current_limit; do
        if [ -f "$path" ]; then
            charger_path="$path"
            break
        fi
    done

    if [ -n "$charger_path" ]; then
        mkdir -p /data/local/tmp/last_path_dir
        echo "$charger_path" > /data/local/tmp/last_path_dir/last_path
        echo "[ThunderCharge] Ditemukan input_current_limit di: $charger_path" >> /data/local/tmp/thundercharge.log
    else
        echo "[ThunderCharge] Tidak ditemukan path input_current_limit" >> /data/local/tmp/thundercharge.log
    fi
}

apply_charging_limit() {
    charger_path=$(cat /data/local/tmp/last_path_dir/last_path 2>/dev/null)

    if [ -z "$charger_path" ]; then
        echo "[ThunderCharge] File last_path tidak ditemukan." >> /data/local/tmp/thundercharge.log
        return
    fi

    current_limit=3000000
    echo "[ThunderCharge] Batas current limit yang diterapkan: $current_limit" >> /data/local/tmp/thundercharge.log

    echo "$current_limit" > "$charger_path"
    if [ $? -eq 0 ]; then
        echo "[ThunderCharge] Current limit diterapkan pada path $charger_path" >> /data/local/tmp/thundercharge.log
    else
        echo "[ThunderCharge] Gagal menerapkan current limit pada path $charger_path" >> /data/local/tmp/thundercharge.log
    fi
}

run_fixcharge() {
    charger_path=$(cat /data/local/tmp/last_path_dir/last_path 2>/dev/null)
    if [ -n "$charger_path" ]; then
        current_limit=3000000
        echo "[ThunderCharge] Menjalankan fixcharge untuk path $charger_path" >> /data/local/tmp/thundercharge.log
        /data/adb/modules/thundercharge/fixcharge "$charger_path" "$current_limit"
    else
        echo "[ThunderCharge] Gagal menjalankan fixcharge: path tidak ditemukan." >> /data/local/tmp/thundercharge.log
    fi
}