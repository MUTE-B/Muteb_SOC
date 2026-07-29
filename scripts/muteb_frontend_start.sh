#!/bin/bash

echo "======================================"
echo " MUTEB SOC FRONTEND START "
echo "======================================"


echo ""
echo "[1] Checking frontend folder"

if [ ! -d frontend ]; then
echo "Frontend folder missing"
exit 1
fi


echo "Frontend OK"



echo ""
echo "[2] Checking Node"


node -v
npm -v



echo ""
echo "[3] Checking existing Vite"


if sudo ss -tulpn | grep ":5173" > /dev/null
then

echo "Frontend already running"

else

echo "Starting Vite..."

cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &

sleep 8

fi



echo ""
echo "[4] Frontend Port"

sudo ss -tulpn | grep ":5173"



echo ""
echo "[5] Frontend Log"

tail -20 frontend.log



echo ""
echo "======================================"
echo " OPEN:"
echo " http://localhost:5173 "
echo "======================================"

