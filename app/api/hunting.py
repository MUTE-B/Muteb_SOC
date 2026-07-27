
from flask import Blueprint, request, jsonify

from app.threat_hunting.hunter import hunt_event

from app.threat_hunting.timeline import create_timeline


hunting = Blueprint(
    "hunting",
    __name__
)


@hunting.route(
    "/search",
    methods=["POST"]
)

def search():

    data = request.json


    events = data.get(
        "events",
        []
    )


    results = []


    for event in events:

        results.extend(
            hunt_event(event)
        )


    return jsonify({

        "engine":
        "MUTEB Threat Hunting Engine",

        "findings":
        results,

        "timeline":
        create_timeline(events),

        "count":
        len(results)

    })
