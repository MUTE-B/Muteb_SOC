#!/bin/bash

#############################################
# MUTEB SOC Security Scanner
# Version: v1.1.0
# Defensive Security Module
#############################################


security_scan(){

echo ""

echo "========== SECURITY SCAN =========="


echo ""
echo "[SYSTEM USER]"

whoami


echo ""
echo "[ACTIVE USERS]"

who


echo ""
echo "[OPEN PORTS]"

ss -tuln


echo ""
echo "[RUNNING SECURITY SERVICES]"


services=("ssh" "ufw" "fail2ban")


for service in "${services[@]}"
do

if systemctl is-active --quiet $service
then

echo "[+] $service : RUNNING"

else

echo "[-] $service : NOT RUNNING"

fi

done


echo ""
echo "[FAILED LOGIN ATTEMPTS]"


if [ -f /var/log/auth.log ]
then

grep "Failed password" /var/log/auth.log | tail -5

else

echo "Auth log not found"

fi


echo ""
echo "==================================="

}
