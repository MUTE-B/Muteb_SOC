
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


