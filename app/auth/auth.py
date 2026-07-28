from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token


auth = Blueprint("auth", __name__)


users = {

    "admin": {
        "password": "muteb123",
        "role": "ADMIN"
    },

    "analyst": {
        "password": "soc123",
        "role": "SOC_ANALYST"
    }

}



@auth.route("/api/login", methods=["POST"])
def login():

    data = request.json

    username = data.get("username")
    password = data.get("password")


    if username in users and users[username]["password"] == password:

        token = create_access_token(
            identity=username
        )


        return jsonify({

            "status":"success",

            "token":token,

            "username":username,

            "role":users[username]["role"]

        })


    return jsonify({

        "status":"failed",

        "message":"Invalid username or password"

    }),401

