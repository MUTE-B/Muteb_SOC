

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.mitre.database import get_coverage



mitre = Blueprint(
    "mitre",
    __name__
)



@mitre.route(
    "/coverage",
    methods=["GET"]
)

@jwt_required()

def coverage():


    data=get_coverage()


    return jsonify({

        "framework":
        "MITRE ATT&CK",

        "techniques":
        len(data),

        "coverage":
        data

    })

