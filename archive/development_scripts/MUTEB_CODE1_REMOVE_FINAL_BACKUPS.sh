#!/bin/bash

echo "======================================"
echo " MUTEB SOC REMOVE FINAL BACKUPS"
echo "======================================"

cd ~/Muteb-SOC || exit 1


rm -f app/database/config_fix.py

rm -f frontend/src/App.jsx.connection_backup
rm -f frontend/src/App.jsx.login_backup

rm -f web_dashboard/app.py.connection_backup
rm -f web_dashboard/app.py.cors_backup


echo "[DONE] Backup cleanup completed"

git status

