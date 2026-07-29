#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL GITHUB SYNC"
echo " CODE 17"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Check Repository"

git status



echo ""
echo "[2] Add Changes"

git add .



echo ""
echo "[3] Commit Final Cleanup"

git commit -m "MUTEB SOC Enterprise v1.0.0 Final Repository Cleanup" || true



echo ""
echo "[4] Push To GitHub"


git push origin develop



echo ""
echo "======================================"
echo " FINAL SYNC COMPLETE"
echo "======================================"


git log -3 --oneline

