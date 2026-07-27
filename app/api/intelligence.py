
from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required


intelligence = Blueprint(
    "intelligence",
    __name__
)


@intelligence.route(
    "/analyze",
    methods=["POST"]
)
@jwt_required()
def analyze():

    data = request.json or {}

    event = data.get(
        "event",
        ""
    )


    if "Failed password" in event:

        classification = {

            "category":"BRUTE_FORCE",

            "mitre":"T1110",

            "name":"Brute Force"

        }

        severity = {

            "score":80,

            "severity":"HIGH"

        }


    elif "sudo" in event:


        classification = {

            "category":"PRIVILEGE_ESCALATION",

            "mitre":"T1548",

            "name":"Privilege Escalation"

        }


        severity = {

            "score":90,

            "severity":"CRITICAL"

        }


    else:


        classification = {

            "category":"UNKNOWN",

            "mitre":"N/A",

            "name":"Unknown Activity"

        }


        severity = {

            "score":20,

            "severity":"LOW"

        }



    return jsonify({

        "event":event,

        "classification":classification,

        "severity":severity

    })

