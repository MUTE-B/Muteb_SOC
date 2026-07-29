#!/bin/bash

echo "======================================"
echo " MUTEB SOC LOGIN DEBUG "
echo "======================================"


echo ""
echo "[1] Check login route inside app.py"

grep -n "api/login\|def login" web_dashboard/app.py



echo ""
echo "[2] Check Flask running process"

ps aux | grep app.py | grep -v grep



echo ""
echo "[3] Show last backend log"

tail -30 backend.log



echo ""
echo "[4] Restart clean backend"


pkill -f "web_dashboard/app.py" || true


source venv/bin/activate


cd web_dashboard


nohup python3 app.py > ../backend.log 2>&1 &


sleep 5


echo ""
echo "[5] Test Login Again"


curl -i -X POST http://172.20.10.4:5000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"muteb123"}'


echo ""
echo "======================================"
echo " DEBUG COMPLETE "
echo "======================================"

