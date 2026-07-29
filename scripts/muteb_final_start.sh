#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL START "
echo "======================================"


echo ""
echo "[1] Backend Status"

sudo ss -tulpn | grep ":5000"



echo ""
echo "[2] Frontend API"

cat frontend/src/api/auth.js



echo ""
echo "[3] Starting Frontend"

cd frontend

npm run dev


