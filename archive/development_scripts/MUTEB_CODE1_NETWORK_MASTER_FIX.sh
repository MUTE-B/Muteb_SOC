#!/bin/bash

echo "======================================"
echo " MUTEB SOC NETWORK MASTER FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


SERVER_IP="172.20.10.4"


echo "[1] Fix Vite Environment"

cat > frontend/.env <<EOF
VITE_API_URL=http://$SERVER_IP:8000
EOF



echo "[2] Replace ALL frontend API addresses"


python3 - <<PY
from pathlib import Path

root = Path("frontend/src")

old = [
    "http://localhost:5000",
    "http://localhost:8000",
    "http://127.0.0.1:8000"
]

new = "http://172.20.10.4:8000"


for file in root.rglob("*"):

    if file.suffix in [".js",".jsx",".ts",".tsx"]:

        try:
            text=file.read_text()

            original=text

            for item in old:
                text=text.replace(item,new)

            if text != original:
                file.write_text(text)
                print("Fixed:",file)

        except:
            pass

PY



echo "[3] Verify remaining localhost references"

grep -R "localhost:5000\|localhost:8000\|127.0.0.1:8000" frontend/src \
--exclude-dir=node_modules || true



echo "[4] Restart Frontend"

pkill -f vite 2>/dev/null || true

sleep 3


cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 8


cd ..



echo "[5] Service Status"

sudo ss -tulpn | grep -E "8000|5173"



echo "[6] Backend Test"

curl http://172.20.10.4:8000/api/health


echo ""

echo "======================================"
echo " FINISHED"
echo "======================================"

echo "Open:"
echo "http://172.20.10.4:5173"

