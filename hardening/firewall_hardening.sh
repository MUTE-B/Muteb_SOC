#!/bin/bash
#
# MUTEB SOC
# Firewall Hardening
#

echo "=== FIREWALL HARDENING ==="


if [[ $EUID -ne 0 ]]; then

echo "[!] Please run as root"

echo "Usage: sudo ./firewall_hardening.sh"

exit 1

fi



if command -v ufw >/dev/null 2>&1

then


echo "[+] Enabling Firewall"


ufw --force enable


echo "[+] Setting Default Rules"


ufw default deny incoming

ufw default allow outgoing


echo "[+] Allowing SSH"


ufw allow ssh


echo "[+] Firewall Hardened Successfully"



else


echo "[!] UFW not installed"


fi

