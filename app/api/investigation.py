

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required



investigation = Blueprint(
    "investigation",
    __name__
)



@investigation.route(
    "/case",
    methods=["POST"]
)

@jwt_required()

def create_case():


    data=request.json or {}


    return jsonify({

        "case_id":
        "CASE-001",

        "status":
        "OPEN",

        "priority":
        data.get(
            "priority",
            "HIGH"
        ),

        "analyst":
        "SOC TEAM"

    })

