#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Disk Monitoring Engine
# ==========================================================

monitor_disk() {

print_title "DISK MONITOR"

df -h --output=source,size,used,avail,pcent,target | while read -r FS SIZE USED AVAIL USE MOUNT
do
    printf "%-20s %-8s %-8s %-8s %-6s %s\n" \
        "$FS" "$SIZE" "$USED" "$AVAIL" "$USE" "$MOUNT"
done

echo

ROOT_USAGE=$(df / | awk 'NR==2 {print $5}')
ROOT_FREE=$(df -h / | awk 'NR==2 {print $4}')

printf "%-20s : %s\n" "Root Usage" "$ROOT_USAGE"
printf "%-20s : %s\n" "Root Free" "$ROOT_FREE"

log_info "Disk Monitor Completed"

}
