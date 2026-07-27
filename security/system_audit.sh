#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Security Audit Engine
# ==========================================================

security_audit() {

print_title "SECURITY AUDIT"

echo "[+] Hostname        : $(hostname)"
echo "[+] Current User    : $(whoami)"
echo "[+] Kernel          : $(uname -r)"
echo "[+] SELinux         : $(getenforce 2>/dev/null || echo Not Installed)"
echo "[+] AppArmor        : $(aa-status 2>/dev/null | head -1 || echo Not Installed)"
echo

echo "[+] Failed SSH Login Attempts"
journalctl -u ssh --no-pager -n 20 2>/dev/null | grep -Ei "failed|invalid|authentication" || echo "None"
echo

echo "[+] Listening TCP Ports"
ss -ltn
echo

echo "[+] Listening UDP Ports"
ss -lun
echo

echo "[+] World Writable Files (Top 20)"
find / -xdev -type f -perm -0002 2>/dev/null | head -20
echo

echo "[+] SUID Files (Top 30)"
find / -xdev -perm -4000 -type f 2>/dev/null | head -30
echo

echo "[+] Recent Login Sessions"
last -a | head -10
echo

echo "[+] Failed Login Records"
lastb 2>/dev/null | head -10 || true
echo

echo "[+] Active Connections"
ss -tunap
echo

echo "[+] Top Processes (CPU)"
ps -eo pid,user,%cpu,%mem,cmd --sort=-%cpu | head
echo

echo "[+] Top Processes (Memory)"
ps -eo pid,user,%cpu,%mem,cmd --sort=-%mem | head
echo

log_success "Security Audit Completed"

}

