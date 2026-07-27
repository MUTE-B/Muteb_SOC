#!/bin/bash
#
# MUTEB SOC
# System Hardening
#


echo "=== SYSTEM HARDENING ==="


echo "[+] Updating Packages"

apt update -y


echo "[+] Installing Security Tools"


apt install -y fail2ban unattended-upgrades


echo "[+] Enabling Security Services"


systemctl enable fail2ban


systemctl start fail2ban


echo "[+] Hardening Completed"

