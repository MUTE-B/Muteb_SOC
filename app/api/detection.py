
from flask import Blueprint, request, jsonify

from app.detection.rule_engine import run_detection


detection = Blueprint(
    "detection",
    __name__
)


@detection.route(
    "/scan",
    methods=["POST"]
)

def scan():

    data = request.json


    results = run_detection(
        data
    )


    return jsonify({

        "engine":
        "MUTEB Detection Engine",

        "detections":
        results,

        "count":
        len(results)

    })
