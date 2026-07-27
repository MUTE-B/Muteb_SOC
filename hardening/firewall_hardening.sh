#!/bin/bash

#
# ==========================================================
# MUTEB SOC v1.1
# Firewall Hardening Toolkit
# ==========================================================
#

echo "======================================"
echo " MUTEB SOC FIREWALL HARDENING"
echo "======================================"



if [[ $EUID -ne 0 ]]; then

echo "[ERROR] Run as root"

exit 1

fi



echo "[+] Enabling UFW..."



ufw --force enable



echo "[+] Default Policies"



ufw default deny incoming

ufw default allow outgoing



echo "[+] Allow SSH"

ufw allow ssh



echo "[+] Allow Web Services"

ufw allow 80/tcp

ufw allow 443/tcp



echo "[+] Enable Firewall Logging"

ufw logging medium



echo

echo "[+] Firewall Rules"

ufw status verbose



echo

echo "[+] Firewall Hardening Completed"

