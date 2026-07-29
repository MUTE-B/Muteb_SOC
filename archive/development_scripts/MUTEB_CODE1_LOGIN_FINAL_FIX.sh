#!/bin/bash


echo "======================================"
echo " MUTEB SOC LOGIN FINAL FIX"
echo "======================================"


cd ~/Muteb-SOC || exit 1


echo "[1] Creating authentication API"


cat > app/api/auth_final.py <<'PY'

from flask import Blueprint, request, jsonify


auth = Blueprint(
    "auth",
    __name__
)


USERS = {
    "admin": "Muteb@123",
    "soc": "SOC@123"
}


@auth.route("/api/login", methods=["POST"])
def login():

    data = request.json or {}

    username = data.get("username")
    password = data.get("password")


    if username in USERS and USERS[username] == password:

        return jsonify({

            "status":"success",
            "message":"Login successful",
            "user": {
                "username": username,
                "role":"SOC Analyst"
            }

        })


    return jsonify({

        "status":"failed",
        "message":"Invalid username or password"

    }),401


PY



echo "[2] Register authentication blueprint"



python3 - <<'PY'

from pathlib import Path


p=Path("app/core/application.py")

text=p.read_text()


if "auth_final" not in text:


    text=text.replace(

    "# Register APIs",

    """
# Authentication API
try:
    from app.api.auth_final import auth
    app.register_blueprint(auth)
except Exception as e:
    print("Auth API warning:",e)


# Register APIs
"""
)


p.write_text(text)


print("Auth registered")

PY



echo "[3] Restart Backend"


pkill -f run.py 2>/dev/null || true

sleep 3


nohup python3 run.py > backend.log 2>&1 &


sleep 5



echo "[4] Test Login"


curl -X POST http://localhost:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@123"}'



echo ""

echo "======================================"
echo " LOGIN READY"
echo "======================================"

echo "Username:"
echo "admin"

echo ""

echo "Password:"
echo "Muteb@123"

echo ""

