#!/bin/bash

echo "================================="
echo " MUTEB SOC FINAL SYSTEM CHECK "
echo "================================="

echo ""
echo "[1] Checking Project Structure..."

if [ -d frontend ]; then
echo "✓ Frontend OK"
else
echo "✗ Frontend Missing"
fi


if [ -d backend ]; then
echo "✓ Backend OK"
else
echo "✗ Backend Missing"
fi


echo ""
echo "[2] Checking Frontend..."

cd frontend || exit

npm run build

if [ $? -eq 0 ]; then
echo "✓ Frontend Build Successful"
else
echo "✗ Frontend Build Failed"
fi


cd ..

echo ""
echo "[3] Checking Git Status..."

git status


echo ""
echo "[4] System Information"

echo "Hostname:"
hostname

echo ""

echo "Kernel:"
uname -r


echo ""
echo "================================="
echo " MUTEB SOC CHECK COMPLETE "
echo "================================="

