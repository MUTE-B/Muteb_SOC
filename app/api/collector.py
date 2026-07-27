from flask import Blueprint, jsonify
from flask_jwt_extended import jwt_required

from app.collector.log_collector import collector
from app.engine.alert_engine import alert_engine



collector_api = Blueprint(
    "collector",
    __name__
)



@collector_api.route(
    "/ssh",
    methods=["GET"]
)
@jwt_required()
def collect_ssh():


    events = collector.collect_ssh()


    alerts = alert_engine.analyze(
        events
    )


    return jsonify({

        "collector":
        "SSH",

        "events":
        len(events),

        "alerts":
        alerts

    })
