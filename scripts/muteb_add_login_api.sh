#!/bin/bash


echo "======================================"
echo " MUTEB SOC ADD LOGIN API "
echo "======================================"


cp web_dashboard/app.py web_dashboard/app.py.backup



python3 - <<'PY'

from pathlib import Path


file = Path("web_dashboard/app.py")

content = file.read_text()


if "/api/login" in content:

    print("Login API already exists")

else:

    addition = '''

@app.route("/api/login", methods=["POST"])
def login():

    from auth import check_auth

    data = request.get_json()

    username = data.get("username")
    password = data.get("password")


    if check_auth(username,password):

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

'''

    content = content.replace(
        "if __name__ == '__main__':",
        addition + "\n\nif __name__ == '__main__':"
    )


    content = content.replace(
        "from flask import Flask, jsonify, render_template",
        "from flask import Flask, jsonify, render_template, request"
    )


    file.write_text(content)

    print("Login API Added")

PY



echo ""
echo "[Restart Backend]"


pkill -f "web_dashboard/app.py" || true


source venv/bin/activate


cd web_dashboard


nohup python3 app.py > ../backend.log 2>&1 &


sleep 5



echo ""
echo "[Testing Login]"


curl -X POST http://172.20.10.4:5000/api/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"muteb123"}'



echo ""
echo ""
echo "======================================"
echo " LOGIN API READY "
echo "======================================"

