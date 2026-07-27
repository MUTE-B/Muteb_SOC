
from flask import Blueprint, jsonify

from app.monitoring.log_collector import collect_auth_logs
from app.monitoring.alert_engine import analyze_event


security = Blueprint(
    "security",
    __name__
)


@security.route(
    "/events"
)

def events():

    collected = collect_auth_logs()

    alerts = []


    for event in collected:

        alerts.extend(
            analyze_event(event)
        )


    return jsonify({

        "events":
        collected,

        "alerts":
        alerts,

        "count":
        len(collected)

    })
