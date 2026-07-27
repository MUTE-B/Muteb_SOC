#!/bin/bash

#
# ==========================================================
# MUTEB SOC v1.1
# Incident Response Evidence Collector
# ==========================================================
#


CASE_DIR="incident/evidence_$(date +%Y%m%d_%H%M%S)"


mkdir -p "$CASE_DIR"



echo "======================================"
echo " MUTEB SOC EVIDENCE COLLECTION"
echo "======================================"



echo "[+] Collecting System Information"


hostnamectl > "$CASE_DIR/system_info.txt"



echo "[+] Collecting Users"


cat /etc/passwd > "$CASE_DIR/users.txt"



echo "[+] Collecting Processes"


ps aux > "$CASE_DIR/processes.txt"



echo "[+] Collecting Network Connections"


ss -tunap > "$CASE_DIR/network.txt"



echo "[+] Collecting Services"


systemctl list-units --type=service > "$CASE_DIR/services.txt"



echo "[+] Collecting Authentication Logs"


cp /var/log/auth.log "$CASE_DIR/auth.log" 2>/dev/null



echo "[+] Evidence Collection Completed"


echo "Location:"
echo "$CASE_DIR"


