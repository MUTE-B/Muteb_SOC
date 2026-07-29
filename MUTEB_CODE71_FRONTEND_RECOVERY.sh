#!/bin/bash

echo "======================================"
echo " MUTEB SOC FRONTEND RECOVERY"
echo " CODE 71"
echo "======================================"

PROJECT="$HOME/Muteb-SOC"

cd "$PROJECT" || exit 1


echo ""
echo "[1] Creating backup..."

mkdir -p recovery_backup

cp frontend/src/App.jsx recovery_backup/App.jsx.backup.$(date +%s) 2>/dev/null || true
cp frontend/package.json recovery_backup/package.json.backup.$(date +%s) 2>/dev/null || true


echo ""
echo "[2] Checking React files..."

find frontend/src -maxdepth 2 -type f | sort


echo ""
echo "[3] Checking imports..."

grep -RniE "import .* from" frontend/src/App.jsx 2>/dev/null


echo ""
echo "[4] Cleaning Vite cache..."

rm -rf frontend/node_modules/.vite


echo ""
echo "[5] Checking dependencies..."

cd frontend || exit 1

npm install


echo ""
echo "[6] Restarting Vite..."

pkill -f "vite" 2>/dev/null || true

sleep 3


nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 8


echo ""
echo "[7] Testing Frontend..."

curl -I --max-time 5 http://localhost:5173


echo ""
echo "[8] Testing Backend..."

curl -s --max-time 5 http://172.20.10.4:8000 || true


echo ""
echo "======================================"
echo " RECOVERY COMPLETE"
echo "======================================"

echo ""
echo "Open:"
echo "http://172.20.10.4:5173"

