#!/bin/bash
set -e

APP_DIR=$HOME/Muteb-SOC
FRONT=$APP_DIR/frontend
BACK=$APP_DIR/backend

echo "===== MUTEB SOC FINAL FIX ====="

cd $APP_DIR

echo "===== FIX REACT ROUTER ====="
cd $FRONT
npm uninstall react-router react-router-dom >/dev/null 2>&1 || true
npm install react-router-dom@6 >/dev/null 2>&1


echo "===== CLEAN TEMP FILES ====="
find $APP_DIR -name "*.log" -not -path "*/node_modules/*" -delete || true
find $APP_DIR -name "*.tmp" -delete || true
find $APP_DIR -name "*.bak" -delete || true


echo "===== CREATE BACKEND SERVICE ====="

sudo bash -c "cat > /etc/systemd/system/muteb-backend.service" <<SERVICE
[Unit]
Description=MUTEB SOC Backend
After=network.target

[Service]
User=$USER
WorkingDirectory=$BACK
ExecStart=/usr/bin/python3 $BACK/app.py
Restart=always

[Install]
WantedBy=multi-user.target
SERVICE


echo "===== CREATE FRONTEND SERVICE ====="

sudo bash -c "cat > /etc/systemd/system/muteb-frontend.service" <<SERVICE
[Unit]
Description=MUTEB SOC Frontend
After=network.target

[Service]
User=$USER
WorkingDirectory=$FRONT
ExecStart=/usr/bin/npm run dev -- --host 0.0.0.0
Restart=always
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
SERVICE


echo "===== ENABLE SERVICES ====="

sudo systemctl daemon-reload

sudo systemctl stop muteb-backend 2>/dev/null || true
sudo systemctl stop muteb-frontend 2>/dev/null || true

sudo systemctl enable muteb-backend
sudo systemctl enable muteb-frontend

sudo systemctl start muteb-backend
sudo systemctl start muteb-frontend


echo "===== BUILD TEST ====="

cd $FRONT
npm run build


echo "===== CHECK SERVICES ====="

systemctl --no-pager status muteb-backend | head -15
echo "----------------"
systemctl --no-pager status muteb-frontend | head -15


echo "===== PORTS ====="

ss -tulpn | grep -E "5173|8000" || true


echo "===== MUTEB SOC READY ====="
echo "Frontend:"
echo "http://localhost:5173"

echo "Backend:"
echo "http://localhost:8000"

