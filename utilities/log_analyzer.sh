#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Log Analysis Engine
# ==========================================================

log_analyzer() {

print_title "LOG ANALYZER"

echo
echo "========== AUTH LOG =========="

if [[ -f /var/log/auth.log ]]; then

echo
echo "[Failed Logins]"
grep -i "Failed password" /var/log/auth.log | tail -20

echo
echo "[Successful Logins]"
grep -i "Accepted password" /var/log/auth.log | tail -20

echo
echo "[Invalid Users]"
grep -i "Invalid user" /var/log/auth.log | tail -20

else

echo "auth.log not found."

fi

echo
echo "========== SYSLOG =========="

if [[ -f /var/log/syslog ]]; then

tail -40 /var/log/syslog

fi

echo
echo "========== KERNEL =========="

dmesg --level=err,warn | tail -30

echo

log_success "Log Analysis Completed"

}

