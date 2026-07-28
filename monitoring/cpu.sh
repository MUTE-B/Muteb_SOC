#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# CPU Monitoring Engine
# ==========================================================

monitor_cpu() {

CPU_MODEL=$(lscpu | awk -F: '/Model name/ {gsub(/^[ \t]+/,"",$2);print $2}')
CPU_CORES=$(nproc)
CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/{print 100-$8}')
LOAD=$(uptime | awk -F'load average:' '{print $2}')

print_title "CPU MONITOR"

printf "%-20s : %s\n" "Model" "$CPU_MODEL"
printf "%-20s : %s\n" "Cores" "$CPU_CORES"
printf "%-20s : %.2f%%\n" "Usage" "$CPU_USAGE"
printf "%-20s : %s\n" "Load" "$LOAD"

log_info "CPU Monitor Completed"

}
