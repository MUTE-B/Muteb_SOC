#!/bin/bash

echo "=========================================="
echo " MUTEB SOC FINAL SYSTEM TEST "
echo "=========================================="


echo ""
echo "[1] Frontend Check"

if curl -I http://localhost:5173 2>/dev/null | grep "200" > /dev/null
then
echo "✅ Frontend OK :5173"
else
echo "❌ Frontend FAILED"
fi



echo ""
echo "[2] Backend Check"

if curl -I http://172.20.10.4:5000 2>/dev/null | grep "200" > /dev/null
then
echo "✅ Backend OK :5000"
else
echo "❌ Backend FAILED"
fi



echo ""
echo "[3] Login API Test"


curl -X POST http://172.20.10.4:5000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"muteb123"}'


echo ""

echo ""
echo "[4] Check Ports"

sudo ss -tulpn | grep -E "5173|5000"



echo ""
echo "=========================================="
echo " SYSTEM READY "
echo "=========================================="

echo ""
echo "OPEN WEBSITE:"
echo "http://localhost:5173"

echo ""
echo "LOGIN:"
echo "Username: admin"
echo "Password: muteb123"

