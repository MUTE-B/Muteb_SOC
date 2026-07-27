#!/bin/bash
#
# MUTEB SOC
# SSH Hardening
#

echo "=== SSH HARDENING ==="


SSHD="/etc/ssh/sshd_config"


if [[ -f "$SSHD" ]]
then

backup="${SSHD}.backup"

cp "$SSHD" "$backup"


sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' "$SSHD"

sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD"


echo "[+] SSH Configuration Updated"


systemctl restart ssh


else

echo "SSH configuration not found"

fi


