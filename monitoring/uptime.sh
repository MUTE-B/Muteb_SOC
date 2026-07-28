#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Uptime Monitoring Engine
# ==========================================================

monitor_uptime() {

print_title "SYSTEM UPTIME"

echo

printf "%-20s : %s\n" "Current Time" "$(date)"
printf "%-20s : %s\n" "Boot Time" "$(who -b | awk '{print $3,$4}')"
printf "%-20s : %s\n" "Uptime" "$(uptime -p)"
printf "%-20s : %s\n" "Logged Users" "$(who | wc -l)"

echo

uptime

log_info "Uptime Monitor Completed"

}
