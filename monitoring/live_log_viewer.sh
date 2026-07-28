#!/bin/bash

#
# ==========================================================
# MUTEB SOC v1.1
# Live Log Viewer
# ==========================================================
#

LOG_FILE="/var/log/auth.log"


clear


echo "================================================="
echo "          MUTEB SOC LIVE LOG VIEWER"
echo "================================================="
echo

echo "[+] Monitoring: $LOG_FILE"
echo
echo "Press CTRL+C to exit"
echo


if [[ ! -f "$LOG_FILE" ]]; then

echo "[ERROR] Log file not found"

exit 1

fi


tail -Fn0 "$LOG_FILE" | while read LINE

do


if echo "$LINE" | grep -qi "Failed password"; then

echo
echo "[HIGH] SSH FAILED LOGIN"
echo "$LINE"


elif echo "$LINE" | grep -qi "Accepted password"; then

echo
echo "[LOW] SSH SUCCESS LOGIN"
echo "$LINE"


elif echo "$LINE" | grep -qi "sudo"; then

echo
echo "[MEDIUM] SUDO ACTIVITY"
echo "$LINE"


elif echo "$LINE" | grep -qi "authentication failure"; then

echo
echo "[HIGH] AUTHENTICATION FAILURE"
echo "$LINE"


else

echo "[INFO] $LINE"


fi


done

