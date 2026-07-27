
from flask import Blueprint,jsonify

from app.dashboard.service import dashboard_summary

dashboard=Blueprint(
    "dashboard",
    __name__
)

@dashboard.route("/summary",methods=["GET"])
def summary():

    return jsonify(
        dashboard_summary()
    )
