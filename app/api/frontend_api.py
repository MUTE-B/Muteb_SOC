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

