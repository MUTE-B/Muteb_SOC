

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.correlation.rules import analyze_event



correlation = Blueprint(
    "correlation",
    __name__
)



@correlation.route(
    "/analyze",
    methods=["POST"]
)

@jwt_required()

def analyze():


    data=request.json or {}


    event=data.get(
        "event",
        ""
    )


    result=analyze_event(
        event
    )


    return jsonify({

        "engine":
        "MUTEB Correlation Engine",

        "matches":
        len(result),

        "detections":
        result

    })

