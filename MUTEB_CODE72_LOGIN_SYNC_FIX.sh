#!/bin/bash

echo "======================================"
echo " MUTEB SOC LOGIN SYNC FIX"
echo " CODE 72"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backup frontend..."

cp frontend/src/App.jsx frontend/src/App.jsx.login_backup.$(date +%s) 2>/dev/null || true


echo "[2] Searching old credentials..."

grep -Rni "Muteb@123\|CHANGE_PASSWORD\|DEMO_LOGIN_DISABLED" \
frontend/src \
app/api \
--exclude-dir=node_modules || true


echo "[3] Removing hardcoded old login checks..."

sed -i 's/Muteb@123/DEMO_LOGIN_DISABLED/g' frontend/src/App.jsx 2>/dev/null || true


echo "[4] Checking API login file..."

grep -n "USERS" -A10 app/api/auth_final.py


echo "[5] Restarting frontend..."

rm -rf frontend/node_modules/.vite

pkill -f vite 2>/dev/null || true

cd frontend || exit 1

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 8


echo ""
echo "======================================"
echo " LOGIN FIX COMPLETE"
echo "======================================"

echo ""
echo "Use:"
echo "Username: admin"
echo "Password: DEMO_LOGIN_DISABLED"

