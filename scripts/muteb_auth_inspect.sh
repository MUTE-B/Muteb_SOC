#!/bin/bash

echo "======================================"
echo " MUTEB SOC AUTH INSPECTION "
echo "======================================"


echo ""
echo "[1] Auth File Content"

cat web_dashboard/auth.py



echo ""
echo "[2] App Imports"

grep -n "import\|auth" web_dashboard/app.py



echo ""
echo "[3] Blueprint Check"

grep -R "Blueprint" -n web_dashboard



echo ""
echo "======================================"
echo " AUTH INSPECTION COMPLETE "
echo "======================================"

