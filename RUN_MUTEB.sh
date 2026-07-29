#!/bin/bash

echo "================================"
echo " MUTEB SOC ENTERPRISE START"
echo "================================"


# Backend

echo "[1] Starting Backend..."

cd backend || exit

nohup python3 app.py > backend.log 2>&1 &

sleep 3


# Test API

echo "[2] Testing API..."

curl http://localhost:8000 || echo "API check failed"


# Frontend

echo ""

echo "[3] Starting Frontend..."

cd ../frontend || exit

nohup npm run dev > frontend.log 2>&1 &


sleep 5


echo ""

echo "================================"
echo " MUTEB SOC IS RUNNING"
echo "================================"

echo ""

echo "Dashboard:"
echo "http://localhost:5173"

echo ""

echo "API:"
echo "http://localhost:8000"

