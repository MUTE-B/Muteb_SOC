#!/bin/bash

echo "================================"
echo "   MUTEB SOC ENTERPRISE v3.1.0"
echo "================================"

echo "[+] Starting Backend..."

cd ~/Muteb-SOC
nohup python3 run.py > logs/backend.log 2>&1 &

sleep 3

echo "[+] Starting Frontend..."

cd ~/Muteb-SOC/frontend
nohup npm run dev -- --host 0.0.0.0 > ../logs/frontend.log 2>&1 &

sleep 5

echo "================================"
echo " MUTEB SOC IS READY"
echo "================================"

ss -tulpn | grep -E "8000|5173"

