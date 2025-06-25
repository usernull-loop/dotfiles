#!/bin/bash
get_cpu_usage() {
    # CPU usage over 1 second interval
    PREV_IDLE=$(awk '/^cpu / {print $5}' /proc/stat)
    PREV_TOTAL=$(awk '/^cpu / {total = 0; for (i=2; i<=8; i++) total += $i; print total}' /proc/stat)
    sleep 5
    IDLE=$(awk '/^cpu / {print $5}' /proc/stat)
    TOTAL=$(awk '/^cpu / {total = 0; for (i=2; i<=8; i++) total += $i; print total}' /proc/stat)

    DIFF_IDLE=$((IDLE - PREV_IDLE))
    DIFF_TOTAL=$((TOTAL - PREV_TOTAL))
    DIFF_USAGE=$((100 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL))

    echo "${DIFF_USAGE}%"
}

get_mem_usage() {
    awk '/MemAvailable/ {avail=$2} /MemTotal/ {total=$2} END {used=(total-avail)/1024; printf "%.0f", used}' /proc/meminfo
}
get_disk_usage() {
    USED_ROOT=$(df --output=used / | awk 'NR==2')
    USED_EFI=$(df --output=used /boot/efi 2>/dev/null | awk 'NR==2')
    TOTAL_USED_KB=$((USED_ROOT + USED_EFI))
    TOTAL_USED_GB=$(echo "$TOTAL_USED_KB" | awk '{printf "%.1f", $1/1024/1024}')
    echo "${TOTAL_USED_GB}G"
}


get_wifi_status() {
    iface=$(ls /sys/class/net | grep -E '^w.*' | head -n 1)
    if [ -n "$iface" ] && grep -q "up" "/sys/class/net/$iface/operstate"; then
        echo "󰖩  Connected"
    else
        echo "󰖪  Disconnected"
    fi
}


get_volume() {
    amixer -c 1 get Master | awk -F'[][]' '/Mono:/ { print $2; exit }'
}


while true; do
    CPU=$(get_cpu_usage)
    MEM=$(get_mem_usage)
    DISK=$(get_disk_usage)
    WIFI=$(get_wifi_status)
    VOL=$(get_volume)
    DATE=$(date '+%a %b %d |   %H:%M')

    echo "  $CPU |   ${MEM}MB |   $DISK | $WIFI | 󰕾 $VOL | 󰃭 $DATE"
done

