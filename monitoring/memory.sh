#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Memory Monitoring Engine
# ==========================================================

monitor_memory() {

MEM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
MEM_USED=$(free -h | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -h | awk '/Mem:/ {print $4}')
MEM_AVAILABLE=$(free -h | awk '/Mem:/ {print $7}')
SWAP_TOTAL=$(free -h | awk '/Swap:/ {print $2}')
SWAP_USED=$(free -h | awk '/Swap:/ {print $3}')

print_title "MEMORY MONITOR"

printf "%-20s : %s\n" "Total" "$MEM_TOTAL"
printf "%-20s : %s\n" "Used" "$MEM_USED"
printf "%-20s : %s\n" "Free" "$MEM_FREE"
printf "%-20s : %s\n" "Available" "$MEM_AVAILABLE"
printf "%-20s : %s\n" "Swap Total" "$SWAP_TOTAL"
printf "%-20s : %s\n" "Swap Used" "$SWAP_USED"

log_info "Memory Monitor Completed"

}
