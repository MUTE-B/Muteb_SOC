
#!/bin/bash

set -e


PROJECT="/home/mte-b/Muteb-SOC"

echo "===================================="
echo " MUTEB SOC GOLD FINAL HARDENING "
echo "===================================="


cd $PROJECT



echo "[1] CLEAN OLD BACKUPS"

rm -f frontend/src/App.jsx.stable_backup 2>/dev/null || true

rm -rf backup_clean 2>/dev/null || true

find . -name "*.save" -delete 2>/dev/null || true



echo "[2] VERIFY BACKEND ENV"


cd backend


if [ ! -d venv ]; then

python3 -m venv venv

fi


./venv/bin/pip install --upgrade pip

./venv/bin/pip install \
flask \
flask-cors \
flask-jwt-extended \
psycopg2-binary \
werkzeug \
requests



echo "[3] CHECK BACKEND"

./venv/bin/python -m py_compile app.py



echo "[4] SYSTEMD REPAIR"


sudo systemctl daemon-reload

sudo systemctl enable muteb-backend.service

sudo systemctl enable muteb-frontend.service



echo "[5] FRONTEND PRODUCTION BUILD"


cd ../frontend


rm -rf dist


npm install


npm run build



echo "[6] NGINX CHECK"


sudo nginx -t



echo "[7] RESTART ALL"


sudo systemctl restart muteb-backend.service

sleep 3


sudo systemctl restart muteb-frontend.service

sudo systemctl restart nginx



echo "[8] HEALTH TEST"


curl -s http://127.0.0.1:8000/health



echo


echo "[9] LOGIN TEST"


curl -s -X POST http://127.0.0.1:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@Admin2026"}'



echo


echo "===================================="
echo " MUTEB SOC GOLD HARDENING COMPLETE "
echo "===================================="

