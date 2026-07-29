from flask import Blueprint,jsonify


dashboard=Blueprint(
    "dashboard",
    __name__
)


@dashboard.route("/api/dashboard")
def home():

    return jsonify({

        "critical_alerts":1,

        "open_incidents":1,

        "active_users":1,

        "threat_score":85

    })
