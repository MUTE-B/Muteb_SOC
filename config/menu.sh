#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Interactive Dashboard
# ==========================================================

main_menu() {

while true
do

clear

show_banner

echo
echo "==================== DASHBOARD ===================="
echo
echo " [1] System Health"
echo " [2] Monitoring Engine"
echo " [3] Security Audit"
echo " [4] Generate Report"
echo " [5] Baseline Check"
echo " [6] File Integrity"
echo " [7] Process Monitor"
echo " [8] Network Monitor"
echo " [9] Exit"
echo
echo "=================================================="
echo

read -rp "Select Option: " OPTION

case "$OPTION" in

1)

system_health_check
;;

2)

monitor_cpu
monitor_memory
monitor_disk
monitor_network
monitor_services
monitor_uptime
;;

3)

security_audit
;;

4)

generate_report
;;

5)

compare_baseline
;;

6)

integrity_monitor
;;

7)

process_monitor
;;

8)

network_monitor
;;

9)

shutdown_engine
;;

*)

print_error "Invalid Option"

;;

esac

echo
read -rp "Press ENTER to continue..."

done

}

