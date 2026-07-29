#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL API REPAIR"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Fix Frontend API URL"


sed -i 's#http://localhost:5000#http://localhost:8000#g' frontend/src/App.jsx


echo "[2] Create missing Flask API routes"


mkdir -p app/api


cat > app/api/frontend_api.py <<'PY'
from flask import Blueprint, jsonify, request

frontend_api = Blueprint(
    "frontend_api",
    __name__
)


@frontend_api.route("/api/health", methods=["GET"])
def health():

    return jsonify({
        "status":"ok",
        "service":"MUTEB SOC Backend"
    })


@frontend_api.route("/api/login", methods=["POST"])
def login():

    data=request.json or {}

    username=data.get("username","")
    password=data.get("password","")


    if username and password:

        return jsonify({

            "success":True,
            "token":"muteb-demo-token",
            "user":{
                "username":username,
                "role":"SOC Analyst"
            }

        })


    return jsonify({

        "success":False,
        "message":"Invalid credentials"

    }),401



@frontend_api.route("/api/rbac/check", methods=["GET"])
def rbac():

    return jsonify({

        "allowed":True,
        "role":"admin"

    })



@frontend_api.route("/api/dashboard", methods=["GET"])
def dashboard():

    return jsonify({

        "alerts":12,
        "incidents":3,
        "status":"active"

    })

PY



echo "[3] Register Blueprint"


python3 - <<'PY'

from pathlib import Path

p=Path("app/core/application.py")

text=p.read_text()


if "frontend_api" not in text:

    text=text.replace(

        "# Register APIs",

        """
# Frontend API
try:
    from app.api.frontend_api import frontend_api
    app.register_blueprint(frontend_api)
except Exception as e:
    print("Frontend API warning:",e)


# Register APIs
"""
    )


p.write_text(text)

print("API registered")

PY



echo "[4] Restart Backend"


pkill -f "run.py" 2>/dev/null || true

sleep 2

nohup python3 run.py > backend.log 2>&1 &


sleep 5



echo "[5] Restart Frontend"


pkill -f "vite" 2>/dev/null || true

cd frontend

nohup npm run dev -- --host 0.0.0.0 > ../frontend.log 2>&1 &


sleep 5


echo ""
echo "======================================"
echo " FINAL STATUS"
echo "======================================"

cd ..

sudo ss -tulpn | grep -E "8000|5173"


echo ""
echo "BACKEND ROUTES"

python3 - <<'PY'

from run import app

for r in app.url_map.iter_rules():
    print(r.rule)

PY


echo ""
echo "DONE"

