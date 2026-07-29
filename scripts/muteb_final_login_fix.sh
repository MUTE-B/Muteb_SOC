#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL LOGIN FIX "
echo "======================================"


echo "[1] Backup app.py"

cp web_dashboard/app.py web_dashboard/app.py.backup2


echo "[2] Add request import"

python3 - <<'PY'
from pathlib import Path

p = Path("web_dashboard/app.py")

c = p.read_text()

if "from flask import Flask, jsonify, render_template, request" not in c:

    c = c.replace(
        "from flask import Flask, jsonify, render_template",
        "from flask import Flask, jsonify, render_template, request"
    )

p.write_text(c)

PY



echo "[3] Add Login API"

cat >> web_dashboard/app.py <<'PYCODE'


@app.route("/api/login", methods=["POST"])
def login():

    from auth import check_auth

    data = request.get_json()

    username = data.get("username")
    password = data.get("password")


    if check_auth(username, password):

        return jsonify({

            "status":"success",
            "username":username,
            "role":"SOC Analyst",
            "token":"MUTEB-SOC-TOKEN"

        })


    return jsonify({

        "status":"failed",
        "message":"Invalid username or password"

    }),401

PYCODE



echo "[4] Stop old backend"

pkill -f "python3 app.py" || true


sleep 3



echo "[5] Start backend"

source venv/bin/activate

cd web_dashboard

nohup python3 app.py > ../backend.log 2>&1 &


sleep 5



echo "[6] Test route"

curl -i -X POST http://172.20.10.4:5000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"muteb123"}'


echo ""
echo "======================================"
echo " COMPLETE "
echo "======================================"

