#!/bin/bash

echo "===== MUTEB SOC SAFE FINAL FIX ====="


# Stop old processes

pkill -f "python3 app.py" 2>/dev/null
pkill -f "vite" 2>/dev/null


# Backend

echo "[1] Backend Fix"

cd backend || exit

python3 -m pip install -r requirements.txt 2>/dev/null || true

nohup python3 app.py > backend.log 2>&1 &

sleep 5


# Frontend

echo "[2] Frontend Fix"

cd ../frontend || exit


npm install 2>/dev/null || true


rm -rf node_modules/.vite 2>/dev/null


nohup npm run dev -- --host 0.0.0.0 > frontend.log 2>&1 &


sleep 8


# Check

echo ""

echo "===== PORT CHECK ====="

ss -tulpn | grep -E "5000|8000|5173"


echo ""

echo "===== BACKEND LOG ====="

tail -10 ../backend/backend.log


echo ""

echo "===== FRONTEND LOG ====="

tail -10 frontend.log


echo ""

echo "================================"

echo " MUTEB SOC STARTED"

echo " Dashboard:"

echo " http://localhost:5173"

echo ""

echo " API:"

echo " http://localhost:8000"

echo "================================"

