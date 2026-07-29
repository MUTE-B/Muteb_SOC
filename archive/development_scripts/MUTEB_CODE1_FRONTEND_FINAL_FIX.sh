#!/bin/bash

echo "======================================"
echo " MUTEB SOC CODE 1 FRONTEND FINAL FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Check Frontend"

if [ ! -d frontend ]; then
    echo "Frontend folder missing"
    exit 1
fi


echo "[2] Fix API URL"

cat > frontend/.env <<EOF
VITE_API_URL=http://localhost:8000
EOF


echo "[3] Stop old Vite"

pkill -f vite 2>/dev/null || true


sleep 3


echo "[4] Install frontend"

cd frontend

if [ ! -d node_modules ]; then

    npm install

fi


echo "[5] Start Vite"

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 8


cd ..


echo ""
echo "======================================"
echo " SERVICE STATUS"
echo "======================================"


sudo ss -tulpn | grep -E "8000|5173"



echo ""
echo "======================================"
echo " FRONTEND LOG"
echo "======================================"

tail -30 frontend.log


echo ""
echo "======================================"
echo " DONE"
echo "======================================"

