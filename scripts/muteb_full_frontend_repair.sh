#!/bin/bash

echo "=========================================="
echo " MUTEB SOC FRONTEND FULL REPAIR "
echo "=========================================="


echo ""
echo "[1] Stop old frontend"

pkill -f vite || true
pkill -f node || true


sleep 3


echo ""
echo "[2] Check frontend"

if [ ! -d frontend ]; then
echo "ERROR: frontend folder missing"
exit 1
fi



echo ""
echo "[3] Check Vite config"


cd frontend


if [ -f vite.config.js ]; then

echo "vite.config.js found"

else

echo "Creating vite.config.js"

cat > vite.config.js <<'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({

plugins:[
react()
],

server:{
host:"0.0.0.0",
port:5173,
strictPort:true
}

})
EOF

fi



echo ""
echo "[4] Install frontend packages"

npm install



echo ""
echo "[5] Start frontend"


nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 8



echo ""
echo "[6] Check port"

sudo ss -tulpn | grep 5173



echo ""
echo "[7] Test localhost"

curl -I http://127.0.0.1:5173



echo ""
echo "[8] Test network IP"

IP=$(hostname -I | awk '{print $1}')

echo "Your Ubuntu IP:"
echo $IP


curl -I http://$IP:5173



echo ""
echo "[9] Logs"

tail -30 ../frontend.log



echo ""
echo "=========================================="
echo " FINISHED "
echo "=========================================="

echo ""
echo "OPEN:"
echo "http://localhost:5173"
echo ""
echo "OR:"
echo "http://$IP:5173"


