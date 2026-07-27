
from flask import Blueprint,jsonify,request
from flask_jwt_extended import jwt_required


enterprise = Blueprint(
    "enterprise",
    __name__
)


@enterprise.route(
    "/stats",
    methods=["GET"]
)
@jwt_required()

def stats():

    return jsonify({

        "platform":"MUTEB SOC Enterprise",

        "dashboard":"ACTIVE",

        "alerts":0,

        "incidents":1,

        "threat_engine":"ONLINE"

    })



@enterprise.route(
    "/syslog",
    methods=["POST"]
)

def syslog():

    data=request.json or {}


    return jsonify({

        "collector":"SYSLOG",

        "status":"RECEIVED",

        "event":data

    })



@enterprise.route(
    "/hunt",
    methods=["POST"]
)
@jwt_required()

def hunt():

    data=request.json or {}


    event=data.get(
        "event",
        ""
    )


    if "Failed password" in event:

        result="SSH_BRUTE_FORCE"

    elif "sudo" in event:

        result="PRIVILEGE_ESCALATION"

    else:

        result="NORMAL"



    return jsonify({

        "engine":"Threat Hunting",

        "result":result

    })

