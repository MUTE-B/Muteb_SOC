#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Professional TUI Dashboard
# ==========================================================


tui_dashboard() {

while true
do

clear


print_title "MUTEB SOC SECURITY DASHBOARD"


echo
echo "================================================"
echo " System Information"
echo "================================================"

echo "Hostname : $(hostname)"
echo "User     : $(whoami)"
echo "Kernel   : $(uname -r)"
echo "IP       : $(hostname -I | awk '{print $1}')"


echo
echo "================================================"
echo " Resource Monitoring"
echo "================================================"


echo "CPU:"
top -bn1 | grep "Cpu(s)"


echo

echo "Memory:"
free -h | grep Mem


echo

echo "Disk:"
df -h / | tail -1



echo
echo "================================================"
echo " Security Status"
echo "================================================"


if systemctl is-active --quiet ssh
then

echo "[+] SSH        : RUNNING"

else

echo "[-] SSH        : STOPPED"

fi



if command -v ufw >/dev/null 2>&1
then

FW=$(ufw status | grep active)

if [[ ! -z "$FW" ]]
then

echo "[+] Firewall   : ENABLED"

else

echo "[-] Firewall   : DISABLED"

fi

else

echo "[!] Firewall   : NOT INSTALLED"

fi



echo
echo "================================================"
echo " Services"
echo "================================================"


systemctl --type=service --state=running | \
grep running | head -5



echo
echo "================================================"
echo " Options"
echo "================================================"

echo "1) Refresh"
echo "2) Exit"

read -p "Select : " OPTION


case $OPTION in


1)

continue

;;


2)

break

;;


*)

echo "Invalid Option"

sleep 2

;;


esac


done


log_success "Dashboard Closed"

}


