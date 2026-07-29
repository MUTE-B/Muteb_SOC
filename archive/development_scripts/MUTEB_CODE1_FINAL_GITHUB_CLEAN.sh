#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL GITHUB CLEAN"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Remove temporary backups"

rm -rf backup backups
rm -rf frontend/MUTEB_BACKUP*
rm -rf frontend/backup_*
rm -rf frontend/src/*.backup*
rm -rf frontend/src/*.code1_backup
rm -rf frontend/vite.config.js.*
rm -rf web_dashboard/*.backup*
rm -rf app/core/*.backup*
rm -rf app/core/*.broken*
rm -rf app/core/*.failed*


echo "[2] Remove logs and reports"

rm -rf logs
rm -rf reports
rm -rf SOC/reports
rm -rf soc_lab/reports
rm -rf docs/reports

rm -f *.log
rm -f *_report.txt


echo "[3] Remove runtime files"

rm -f backend.pid
rm -f frontend.pid


echo "[4] Update gitignore"


cat >> .gitignore <<'EOF'

# Runtime
*.pid
*.log

# Reports
reports/
logs/
SOC/reports/
soc_lab/reports/
docs/reports/

# Backup files
backup/
backups/
*.backup*
*.broken*
*.failed*

# Temporary scripts
MUTEB_*.sh
scripts/muteb_*.sh

EOF


echo "[5] Check status"

git status


echo ""
echo "======================================"
echo " CLEAN COMPLETE"
echo "======================================"

