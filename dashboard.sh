#!/bin/bash

# ==========================================================
# الهدف:
# لوحة معلومات مشروع Muteb SOC.
# ==========================================================

clear

PROJECT_NAME="Muteb-SOC"

OS_NAME=$(hostnamectl | awk -F': ' '/Operating System/{print $2}')
HOSTNAME=$(hostname)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print 100-$8"%"}')

MEMORY_USAGE=$(free -h | awk '/Mem:/ {print $3" / "$2}')

DISK_USAGE=$(df -h / | awk 'NR==2 {print $3" / "$2" ("$5")"}')

SSH_STATUS=$(systemctl is-active ssh 2>/dev/null)

UFW_STATUS=$(systemctl is-active ufw 2>/dev/null)

FAILED_LOGIN=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)

echo "============================================================"
echo "                     $PROJECT_NAME"
echo "============================================================"

echo

echo "System Information"

echo "------------------------------------------------------------"

printf "%-20s %s\n" "Hostname:" "$HOSTNAME"

printf "%-20s %s\n" "Operating System:" "$OS_NAME"

printf "%-20s %s\n" "Kernel:" "$KERNEL"

printf "%-20s %s\n" "Uptime:" "$UPTIME"

echo

echo "Resource Usage"

echo "------------------------------------------------------------"

printf "%-20s %s\n" "CPU:" "$CPU_USAGE"

printf "%-20s %s\n" "Memory:" "$MEMORY_USAGE"

printf "%-20s %s\n" "Disk:" "$DISK_USAGE"

echo

echo "Security Status"

echo "------------------------------------------------------------"

printf "%-20s %s\n" "SSH:" "$SSH_STATUS"

printf "%-20s %s\n" "Firewall:" "$UFW_STATUS"

printf "%-20s %s\n" "Failed Logins:" "$FAILED_LOGIN"

echo

echo "============================================================"
echo "Dashboard Completed Successfully"
echo "============================================================"
