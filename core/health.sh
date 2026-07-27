#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Health Engine
# ==========================================================

system_health_check() {

log_section "System Health"

CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)
MEMORY_USED=$(free -h | awk '/Mem:/ {print $3}')
MEMORY_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_PERCENT=$(df -h / | awk 'NR==2 {print $5}')
UPTIME=$(uptime -p)

echo
print_title "SYSTEM HEALTH"

printf "%-22s : %s\n" "Hostname" "$HOSTNAME"
printf "%-22s : %s\n" "Kernel" "$KERNEL"
printf "%-22s : %s\n" "Architecture" "$ARCH"
printf "%-22s : %s\n" "CPU Cores" "$CPU_CORES"
printf "%-22s : %s\n" "CPU Load" "$CPU_LOAD"
printf "%-22s : %s / %s\n" "Memory" "$MEMORY_USED" "$MEMORY_TOTAL"
printf "%-22s : %s / %s (%s)\n" "Disk" "$DISK_USED" "$DISK_TOTAL" "$DISK_PERCENT"
printf "%-22s : %s\n" "Uptime" "$UPTIME"

log_info "CPU Load : $CPU_LOAD"
log_info "Memory : $MEMORY_USED / $MEMORY_TOTAL"
log_info "Disk : $DISK_USED / $DISK_TOTAL ($DISK_PERCENT)"
log_info "Uptime : $UPTIME"

}

