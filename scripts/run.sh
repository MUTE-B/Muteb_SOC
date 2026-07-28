#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"
FRONTEND="$ROOT/frontend"
LOG="$ROOT/logs"

mkdir -p "$LOG"


source "$ROOT/venv/bin/activate" 2>/dev/null || true


pkill -f "python3 run.py" || true
pkill -f "vite" || true


echo "========================================="
echo "       MUTEB SOC ENTERPRISE START"
echo "========================================="


cd "$ROOT"


echo "[1] BACKEND START"


nohup python3 run.py \
>"$LOG/backend.log" 2>&1 &


echo $! > backend.pid


sleep 5



echo "[2] BACKEND CHECK"


curl -s \
http://127.0.0.1:8000/api/version/info \
| python3 -m json.tool



echo


echo "[3] FRONTEND CHECK"


cd "$FRONTEND"


if ! command -v npm >/dev/null

then

sudo apt update

sudo apt install -y npm nodejs

fi



if [ ! -d node_modules ]

then

npm install

fi



echo "[4] FRONTEND START"


nohup npm run dev \
-- --host 0.0.0.0 \
>"$LOG/frontend.log" 2>&1 &



echo $! > "$ROOT/frontend.pid"



sleep 10



cd "$ROOT"



echo

echo "========================================="

echo "          STATUS"

echo "========================================="


ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep || true



echo

echo "========================================="

echo "          PORTS"

echo "========================================="


ss -tulpn | grep -E \
"8000|5173|22|80" || true



echo

echo "========================================="

echo "          LINKS"

echo "========================================="


echo "BACKEND"

echo "http://172.20.10.4:8000"


echo


echo "FRONTEND"

echo "http://172.20.10.4:5173"


echo

echo "========================================="

echo " MUTEB SOC READY"

echo "========================================="


