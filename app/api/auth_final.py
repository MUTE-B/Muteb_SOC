
from flask import Blueprint, request, jsonify


auth = Blueprint("auth", __name__)


USERS = {

    "admin": "DEMO_LOGIN_DISABLED",
    "soc": "SOC@123",
    "mte-b": "DEMO_LOGIN_DISABLED"

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


