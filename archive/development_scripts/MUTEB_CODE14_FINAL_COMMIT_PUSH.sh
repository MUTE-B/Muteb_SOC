#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL COMMIT & PUSH"
echo " CODE 14"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Check Git"

git status



echo ""
echo "[2] Add Changes"


git add .



echo ""
echo "[3] Create Final Commit"


git commit -m "MUTEB SOC Enterprise v1.0.0 Final Portfolio Release" || true



echo ""
echo "[4] Push Develop"


git push origin develop



echo ""
echo "======================================"
echo " FINAL PUSH COMPLETE"
echo "======================================"


git log -1 --oneline


