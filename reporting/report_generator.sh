#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Report Generator
# ==========================================================

generate_report() {

REPORT="$REPORT_DIR/MUTEB_SOC_$(date +%F_%H-%M-%S).txt"

{

echo "==============================================================="
echo "                    MUTEB SOC REPORT"
echo "==============================================================="
echo
echo "Date          : $(date)"
echo "Hostname      : $(hostname)"
echo "Kernel        : $(uname -r)"
echo "Architecture  : $(uname -m)"
echo "Current User  : $(whoami)"
echo

echo "================ SYSTEM =================="
uptime
echo
free -h
echo
df -h
echo

echo "================ CPU ====================="
lscpu
echo

echo "================ NETWORK ================="
ip -br addr
echo
ip route
echo
ss -tuln
echo

echo "================ SERVICES ================"
systemctl --type=service --state=running --no-pager
echo

echo "================ USERS ==================="
who
echo
last -n 15
echo

echo "================ PROCESSES ==============="
ps aux --sort=-%cpu | head -20
echo

echo "================ SECURITY ================"
journalctl -u ssh -n 50 --no-pager 2>/dev/null
echo

echo "================ END ====================="

} > "$REPORT"

print_success "Report Saved -> $REPORT"

log_success "Report Generated"

}

