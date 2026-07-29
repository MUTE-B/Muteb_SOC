#!/bin/bash

echo "======================================"
echo " MUTEB SOC BACKEND FIX & START "
echo "======================================"


PROJECT=$(pwd)


echo ""
echo "[1] Checking Backend..."


if [ ! -f "web_dashboard/app.py" ]; then

echo "ERROR: web_dashboard/app.py not found"

exit 1

fi


echo "OK - Backend Found"



echo ""
echo "[2] Activating Virtual Environment"



if [ -d "venv" ]; then

source venv/bin/activate

echo "OK - Virtual Environment Activated"

else

echo "WARNING - venv not found"

fi



echo ""
echo "[3] Installing Requirements"


if [ -f "requirements.txt" ]; then

pip install -r requirements.txt

fi


if [ -f "web_dashboard/requirements.txt" ]; then

pip install -r web_dashboard/requirements.txt

fi



echo ""
echo "[4] Stopping Old Backend Processes"


pkill -f "web_dashboard/app.py" 2>/dev/null || true



echo ""
echo "[5] Starting MUTEB SOC Backend"


cd web_dashboard


nohup python3 app.py > ../backend.log 2>&1 &


sleep 5



echo ""
echo "[6] Backend Logs"

cat ../backend.log



echo ""
echo "[7] Checking Ports"

sudo ss -tulpn | grep -E "5000|8000"



echo ""
echo "[8] API Test"


curl -I http://127.0.0.1:5000 2>/dev/null || true

curl -I http://127.0.0.1:8000 2>/dev/null || true



echo ""
echo "======================================"
echo " BACKEND START COMPLETE "
echo "======================================"

echo ""
echo "If backend runs on port 5000 update:"
echo "frontend/src/api/auth.js"
echo ""
echo 'API_URL=http://172.20.10.4:5000'

echo ""
echo "If backend runs on port 8000 keep:"
echo 'API_URL=http://172.20.10.4:8000'

