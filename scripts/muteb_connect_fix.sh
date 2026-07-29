#!/bin/bash

echo "======================================"
echo " MUTEB SOC FRONTEND-BACKEND CONNECT FIX "
echo "======================================"


PROJECT=$(pwd)


echo ""
echo "[1] Updating Frontend API URL"


if [ -f frontend/src/api/auth.js ]; then

sed -i 's#http://172.20.10.4:8000#http://172.20.10.4:5000#g' frontend/src/api/auth.js

echo "OK - API URL Updated"

else

echo "ERROR - auth.js not found"

exit 1

fi



echo ""
echo "[2] Checking Backend Process"


if sudo ss -tulpn | grep ":5000" > /dev/null
then

echo "OK - Backend already running"

else

echo "Starting Backend..."

source venv/bin/activate

cd web_dashboard

nohup python3 app.py > ../backend.log 2>&1 &

cd ..

sleep 5

fi



echo ""
echo "[3] Backend Status"

sudo ss -tulpn | grep ":5000"



echo ""
echo "[4] API Configuration"

cat frontend/src/api/auth.js



echo ""
echo "[5] Frontend Status"

if sudo ss -tulpn | grep ":5173" > /dev/null
then

echo "OK - Frontend running"

else

echo "Frontend is not running"
echo "Start it with:"
echo "cd frontend && npm run dev"

fi



echo ""
echo "======================================"
echo " CONNECTION FIX COMPLETED "
echo "======================================"

echo ""
echo "Open:"
echo "http://localhost:5173"

