#!/bin/bash

echo "======================================"
echo " MUTEB SOC FULL CONNECTION TEST"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Backend Health"

curl -s http://localhost:8000/api/health

echo ""
echo ""


echo "[2] Login API Test"

curl -s -X POST http://localhost:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@123"}'


echo ""
echo ""


echo "[3] Frontend API references"

grep -R "localhost:5000\|localhost:8000\|172.20.10.4:8000" frontend/src \
--exclude-dir=node_modules || true


echo ""
echo ""


echo "[4] Services"

sudo ss -tulpn | grep -E "5173|8000"


echo ""
echo "======================================"
echo " TEST COMPLETE"
echo "======================================"

