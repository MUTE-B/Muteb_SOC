#!/bin/bash

echo "======================================"
echo " MUTEB SOC SYSTEM FINAL CHECK"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo ""
echo "[1] Backend Port"
ss -tlnp | grep 8000 || echo "Backend not running"


echo ""
echo "[2] Frontend Port"
ss -tlnp | grep 5173 || echo "Frontend not running"


echo ""
echo "[3] Backend Health"

curl -s http://localhost:8000/api/health


echo ""
echo ""
echo "[4] Login Test"

curl -s -X POST http://localhost:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@123"}'


echo ""
echo ""
echo "[5] Frontend API URL"

cat frontend/.env


echo ""
echo "======================================"
echo " CHECK COMPLETE"
echo "======================================"

