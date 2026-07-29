#!/bin/bash

echo "======================================"
echo " MUTEB SOC ROUTE VERIFY "
echo "======================================"


echo ""
echo "[1] Search login in all python files"

grep -R "api/login\|def login" -n web_dashboard



echo ""
echo "[2] Show app.py last 60 lines"

tail -60 web_dashboard/app.py



echo ""
echo "[3] Running Flask process"

ps aux | grep python | grep app.py | grep -v grep



echo ""
echo "[4] Flask URL test"

curl -s http://172.20.10.4:5000/



echo ""
echo "======================================"
echo " VERIFY COMPLETE "
echo "======================================"

