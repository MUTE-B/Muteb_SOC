#!/bin/bash

echo "======================================"
echo " MUTEB SOC API ROUTE DIAGNOSTIC "
echo "======================================"


echo ""
echo "[1] Flask Routes"


grep -R "@.*route" -n web_dashboard 2>/dev/null || echo "No routes found"



echo ""
echo "[2] Login References"


grep -R "login" -n web_dashboard 2>/dev/null || echo "No login function found"



echo ""
echo "[3] Backend Python Files"


find web_dashboard -maxdepth 2 -type f -name "*.py"



echo ""
echo "[4] Testing Common Login Endpoints"


echo ""
echo "Testing /api/login"

curl -s -o /dev/null -w "%{http_code}\n" \
-X POST http://172.20.10.4:5000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"admin"}'



echo ""
echo "Testing /login"

curl -s -o /dev/null -w "%{http_code}\n" \
-X POST http://172.20.10.4:5000/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"admin"}'



echo ""
echo "Testing /api/auth/login"

curl -s -o /dev/null -w "%{http_code}\n" \
-X POST http://172.20.10.4:5000/api/auth/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"admin"}'



echo ""
echo "======================================"
echo " API CHECK COMPLETE "
echo "======================================"

