#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE UI REBUILD"
echo " CODE 21"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Creating frontend backup"

mkdir -p frontend/UI_BACKUP_CODE21

cp frontend/src/App.jsx frontend/UI_BACKUP_CODE21/App.jsx.backup 2>/dev/null || true
cp frontend/src/App.css frontend/UI_BACKUP_CODE21/App.css.backup 2>/dev/null || true


echo "[2] Backup completed"


echo "[3] Preparing Enterprise UI files"


echo ""
echo "Waiting for next package..."
echo "App.jsx and App.css will be replaced in next step"


echo ""
echo "======================================"
echo " CODE 21 PREPARED"
echo " Backup location:"
echo " frontend/UI_BACKUP_CODE21"
echo "======================================"

