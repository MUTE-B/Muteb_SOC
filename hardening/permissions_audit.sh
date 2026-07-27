#!/bin/bash

#
# ==========================================================
# MUTEB SOC v1.1
# Permissions Security Audit
# ==========================================================
#

echo "======================================"
echo " MUTEB SOC PERMISSIONS AUDIT"
echo "======================================"


REPORT="reports/permissions_audit.txt"


mkdir -p reports



echo "MUTEB SOC Permissions Audit" > $REPORT

echo "Date: $(date)" >> $REPORT

echo "" >> $REPORT



echo "===== SUID FILES =====" >> $REPORT


find / -perm -4000 -type f 2>/dev/null >> $REPORT



echo "" >> $REPORT


echo "===== WORLD WRITABLE FILES =====" >> $REPORT


find / -type f -perm -0002 2>/dev/null | head -100 >> $REPORT



echo "" >> $REPORT


echo "===== SSH KEY PERMISSIONS =====" >> $REPORT


find /home -name authorized_keys -exec ls -l {} \; 2>/dev/null >> $REPORT



echo "" >> $REPORT


echo "===== ETC DIRECTORY =====" >> $REPORT


ls -ld /etc >> $REPORT



echo

echo "[+] Audit Completed"

echo "[+] Report:"
echo $REPORT


