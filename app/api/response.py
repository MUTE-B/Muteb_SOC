

from flask import Blueprint,request,jsonify

from flask_jwt_extended import jwt_required


from app.intelligence.threat_classifier import classifier

from app.intelligence.severity import severity_engine

from app.response.incident_response import incident_response



response_api = Blueprint(
    "response",
    __name__
)



@response_api.route(
    "/create",
    methods=["POST"]
)

@jwt_required()

def create():


    data=request.json or {}


    event=data.get(
        "event",
        ""
    )


    threat=classifier.classify(
        event
    )


    severity=severity_engine.calculate(
        threat
    )


    incident=incident_response.create_incident(
        threat,
        severity,
        event
    )


    return jsonify({

        "engine":
        "MUTEB Automated Response",

        "incident":
        incident

    })

