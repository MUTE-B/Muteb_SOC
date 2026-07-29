#!/bin/bash

echo "======================================"
echo " MUTEB SOC CODE 1 BACKEND RECOVERY"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Stop old backend"

pkill -f "run.py" 2>/dev/null || true

sleep 3


echo "[2] Check application syntax"

python3 -m py_compile app/core/application.py

if [ $? -ne 0 ]; then
    echo "APPLICATION.PY ERROR"
    exit 1
fi


echo "[3] Check database module"

python3 - <<'PY'
from app.database.database import db
print("Database module OK")
PY


echo "[4] Start backend"

nohup python3 run.py > backend.log 2>&1 &


sleep 6


echo "[5] Port status"

sudo ss -tulpn | grep 8000 || true


echo ""
echo "[6] Health Test"

curl http://localhost:8000/api/health || true


echo ""
echo "[7] Backend Log"

tail -50 backend.log


echo ""
echo "======================================"
echo " BACKEND RECOVERY FINISHED"
echo "======================================"

