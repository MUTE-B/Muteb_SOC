#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL VALIDATION"
echo " CODE 6"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Check Frontend folder"

if [ ! -d frontend ]; then

echo "Frontend missing"

exit 1

fi



echo "[2] Check package"

cd frontend || exit 1


if [ ! -d node_modules ]; then

echo "Installing dependencies"

npm install

fi



echo "[3] React syntax check"


npm run build


if [ $? -ne 0 ]; then

echo "BUILD FAILED"

exit 1

fi



echo "[4] Restart frontend"


pkill -f vite 2>/dev/null || true


sleep 3


nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &



sleep 5



echo "[5] Frontend Status"


tail -30 ../frontend.log



echo ""
echo "======================================"
echo " FINAL VALIDATION COMPLETE"
echo "======================================"

echo ""
echo "Open:"
echo "http://172.20.10.4:5173"


