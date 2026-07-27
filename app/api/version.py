

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required

from app.core.version import VERSION,PROJECT,STATUS



version_api = Blueprint(
    "version",
    __name__
)



@version_api.route(
    "/info",
    methods=["GET"]
)

@jwt_required()

def info():


    return jsonify({

        "project":PROJECT,

        "version":VERSION,

        "status":STATUS,

        "security_platform":
        "SOC Enterprise"

    })

