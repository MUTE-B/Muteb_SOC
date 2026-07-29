#!/bin/bash

echo "======================================"
echo " MUTEB SOC LOGIN COMPATIBILITY FIX"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Rebuild login API"


cat > app/api/auth_final.py <<'PY'

from flask import Blueprint, request, jsonify


auth = Blueprint("auth", __name__)


USERS = {

    "admin": "Muteb@123",
    "soc": "SOC@123",
    "mte-b": "Muteb@123"

}


@auth.route("/api/login", methods=["POST"])
def login():

    data = request.get_json() or {}


    username = (
        data.get("username")
        or data.get("email")
        or data.get("user")
    )

    password = data.get("password")


    print("LOGIN ATTEMPT:", username)


    if username in USERS and USERS[username] == password:


        return jsonify({

            "success": True,
            "token": "muteb-demo-token",
            "user": {

                "username": username,
                "role": "SOC Analyst"

            }

        })


    return jsonify({

        "success": False,
        "message": "Invalid Credentials"

    }),401


PY



echo "[2] Restart Backend"


pkill -f run.py 2>/dev/null || true

sleep 3

nohup python3 run.py > backend.log 2>&1 &


sleep 6



echo "[3] Test login manually"


curl -X POST http://172.20.10.4:8000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Muteb@123"}'


echo ""

echo "======================================"
echo " DONE"
echo "======================================"

