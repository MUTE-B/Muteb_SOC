#!/bin/bash

echo "===================================="
echo " MUTEB SOC FINAL CONNECTION FIX"
echo "===================================="


cd ~/Muteb-SOC || exit 1


echo "[1] Detecting Flask port..."

sed -i 's/VITE_API_URL=.*/VITE_API_URL=http:\/\/localhost:8000/' frontend/.env


echo "[2] Fix database configuration..."

cat > app/database/config_fix.py <<'PY'
import os

DATABASE_URL=os.getenv(
    "DATABASE_URL",
    "sqlite:///muteb_soc.db"
)
PY



echo "[3] Finding SOC Blueprint..."

grep -n "Blueprint" app/api/soc.py



echo "[4] Restart Backend..."

pkill -f "run.py" 2>/dev/null || true

sleep 2

nohup python3 run.py > backend.log 2>&1 &


sleep 5


echo "[5] Check Port"

sudo ss -tulpn | grep 8000 || true


echo "[6] Backend Log"

tail -50 backend.log


echo "===================================="
echo " DONE"
echo "===================================="

