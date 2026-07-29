#!/bin/bash

echo "======================================"
echo " MUTEB SOC CODE 1 MASTER FINAL FIX"
echo "======================================"

PROJECT=$HOME/Muteb-SOC

cd $PROJECT || exit 1


echo ""
echo "[1] Killing old services..."

pkill -f "run.py" 2>/dev/null || true
pkill -f "vite" 2>/dev/null || true

sleep 3



echo ""
echo "[2] Fix Backend application..."

python3 -m py_compile app/core/application.py

if [ $? -ne 0 ]; then
echo "application.py syntax error"
exit 1
fi



echo ""
echo "[3] Ensure Frontend API URL..."

cat > frontend/.env <<EOF
VITE_API_URL=http://localhost:8000
EOF



echo ""
echo "[4] Start Backend..."

nohup python3 run.py > backend.log 2>&1 &

sleep 5



echo ""
echo "[5] Start Frontend..."

cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &

cd ..

sleep 8



echo ""
echo "======================================"
echo " PORT STATUS"
echo "======================================"

sudo ss -tulpn | grep -E "8000|5173"



echo ""
echo "======================================"
echo " BACKEND TEST"
echo "======================================"

curl -I http://localhost:8000/api/health || true



echo ""
echo "======================================"
echo " FRONTEND TEST"
echo "======================================"

curl -I http://localhost:5173 || true



echo ""
echo "======================================"
echo " FINAL URLS"
echo "======================================"

echo "Backend:"
echo "http://localhost:8000"

echo ""

echo "Frontend:"
echo "http://localhost:5173"

echo ""

echo "Network Frontend:"
echo "http://172.20.10.4:5173"


echo ""
echo "======================================"
echo " DONE"
echo "======================================"

