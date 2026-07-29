#!/bin/bash

set -e

PROJECT="$HOME/Muteb-SOC"

echo "====================================="
echo " MUTEB SOC GOLD FINAL ENTERPRISE"
echo "====================================="


cd "$PROJECT"


echo "[1] BACKUP CURRENT"

mkdir -p gold_backup

cp backend/app.py gold_backup/app.py.$(date +%s) 2>/dev/null || true

cp -r frontend/src gold_backup/frontend.$(date +%s) 2>/dev/null || true



echo "[2] BACKEND ENVIRONMENT"


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



./venv/bin/python -m py_compile app.py



cd "$PROJECT"



echo "[3] BACKEND HEALTH"

if ! grep -q "muteb_health" backend/app.py
then

cat >> backend/app.py <<'PY'


@app.route("/health")
def muteb_health():

    return jsonify({
        "system":"MUTEB SOC Enterprise",
        "status":"ONLINE"
    })


PY

fi



echo "[4] BACKEND SERVICE"

sudo systemctl daemon-reload

sudo systemctl enable muteb-backend.service

sudo systemctl restart muteb-backend.service


sleep 3



echo "[5] FRONTEND AUTH CHECK"


cd frontend


if [ -f src/App.jsx ]; then

grep -q "localStorage" src/App.jsx || echo "AUTH STORAGE CHECK REQUIRED"

fi



echo "[6] REMOVE OLD BUILD"

rm -rf dist



echo "[7] FRONTEND BUILD"

npm install

npm run build



cd "$PROJECT"



echo "[8] SERVICES"

sudo systemctl enable muteb-frontend.service

sudo systemctl restart muteb-frontend.service

sudo systemctl restart nginx



echo "[9] NGINX TEST"

sudo nginx -t



echo "[10] API TEST"


echo "--- HEALTH ---"

curl -s http://127.0.0.1:8000/health || true



echo

echo "--- LOGIN ---"


curl -s -X POST http://127.0.0.1:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@Admin2026"}' \
| head -c 200



echo


echo "[11] STATUS"


systemctl is-active muteb-backend.service

systemctl is-active muteb-frontend.service

systemctl is-active nginx.service



echo

echo "====================================="
echo " MUTEB SOC ENTERPRISE READY"
echo "====================================="

