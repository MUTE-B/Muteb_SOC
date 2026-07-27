
from flask import Blueprint, request, jsonify

from flask_jwt_extended import jwt_required


detection_pipeline = Blueprint(
    "pipeline",
    __name__
)



@detection_pipeline.route(
    "/analyze",
    methods=["POST"]
)
@jwt_required()
def analyze():


    data = request.json or {}


    log = data.get(
        "log",
        ""
    )


    detections=[]


    if "Failed password" in log:

        detections.append({

            "rule":"SSH_BRUTE_FORCE",

            "severity":"HIGH",

            "source":"Authentication Log"

        })


    if "sudo" in log:

        detections.append({

            "rule":"PRIVILEGE_ESCALATION",

            "severity":"MEDIUM",

            "source":"Linux Audit"

        })



    return jsonify({

        "engine":
        "MUTEB Detection Pipeline",

        "detections":
        detections,

        "count":
        len(detections)

    })

