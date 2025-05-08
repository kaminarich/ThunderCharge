#!/system/bin/sh
MODDIR=${0%/*}

# Jalankan pengaturan charging saat service dimulai
sh "$MODDIR/charge.sh" &