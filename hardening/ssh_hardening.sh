#!/bin/bash

#
# ==========================================================
# MUTEB SOC v1.1
# SSH Hardening Toolkit
# ==========================================================
#

echo "======================================"
echo " MUTEB SOC SSH HARDENING"
echo "======================================"

SSH_CONFIG="/etc/ssh/sshd_config"


if [[ $EUID -ne 0 ]]; then

echo "[ERROR] Run as root"

exit 1

fi



cp $SSH_CONFIG ${SSH_CONFIG}.backup


sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' $SSH_CONFIG

sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' $SSH_CONFIG


sed -i 's/^#MaxAuthTries.*/MaxAuthTries 3/' $SSH_CONFIG

sed -i 's/^MaxAuthTries.*/MaxAuthTries 3/' $SSH_CONFIG



systemctl restart ssh



echo
echo "[+] SSH Hardening Completed"
echo "[+] Backup:"
echo "${SSH_CONFIG}.backup"

