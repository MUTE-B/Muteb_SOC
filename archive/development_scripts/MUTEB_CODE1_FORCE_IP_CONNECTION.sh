#!/bin/bash

echo "======================================"
echo " MUTEB SOC FORCE IP CONNECTION FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Update frontend environment"

cat > frontend/.env <<EOF
VITE_API_URL=http://172.20.10.4:8000
EOF



echo "[2] Search old API URLs"

grep -R "localhost:5000\|localhost:8000\|127.0.0.1:8000" frontend/src \
--exclude-dir=node_modules || true



echo "[3] Replace old URLs"

find frontend/src -type f \\( -name "*.js" -o -name "*.jsx" \\) \
-not -path "*node_modules*" \
-exec sed -i \
-e 's#http://localhost:5000#http://172.20.10.4:8000#g' \
-e 's#http://localhost:8000#http://172.20.10.4:8000#g' \
-e 's#http://127.0.0.1:8000#http://172.20.10.4:8000#g' {} \;



echo "[4] Restart Vite"

pkill -f vite 2>/dev/null || true

sleep 3

cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &

sleep 7


echo ""
echo "======================================"
echo " FINAL CHECK"
echo "======================================"

cd ..

echo "Ports:"
sudo ss -tulpn | grep -E "8000|5173"


echo ""
echo "Frontend API references:"

grep -R "localhost:5000\|localhost:8000" frontend/src \
--exclude-dir=node_modules || true


echo ""
echo "DONE"

