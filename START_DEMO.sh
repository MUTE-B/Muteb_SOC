#!/bin/bash

echo "================================="
echo "     MUTEB SOC ENTERPRISE"
echo "     FINAL DEMO START"
echo "================================="

echo "[+] Starting Backend..."

cd ~/Muteb-SOC
nohup python3 run.py > logs/backend.log 2>&1 &

sleep 3

echo "[+] Starting Frontend..."

cd ~/Muteb-SOC/frontend
npm run dev -- --host 0.0.0.0

