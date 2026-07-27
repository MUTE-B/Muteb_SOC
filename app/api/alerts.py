
from flask import Blueprint,jsonify

from app.services.alert_service import latest_alerts

alerts=Blueprint(
    "alerts",
    __name__
)

@alerts.route("/",methods=["GET"])
def all_alerts():

    data=latest_alerts()

    return jsonify({

        "count":len(data),

        "alerts":data

    })
