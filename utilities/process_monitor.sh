#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Process Monitor
# ==========================================================

process_monitor() {

print_title "PROCESS MONITOR"

echo
echo "Top CPU Processes"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -15

echo
echo "Top Memory Processes"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -15

echo
echo "Zombie Processes"
ps aux | awk '$8 ~ /Z/'

echo

log_success "Process Monitor Completed"

}

