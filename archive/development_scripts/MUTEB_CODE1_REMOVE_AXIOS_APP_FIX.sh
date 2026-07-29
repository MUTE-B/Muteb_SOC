#!/bin/bash

echo "======================================"
echo " MUTEB SOC REMOVE AXIOS FROM APP FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Remove axios import from App.jsx"


sed -i '/import axios from "axios";/d' frontend/src/App.jsx



echo "[2] Ensure axios installed for api client"

cd frontend

npm install axios


echo "[3] Restart frontend"

pkill -f vite 2>/dev/null || true

sleep 3

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " STATUS"
echo "======================================"

tail -30 ../frontend.log


