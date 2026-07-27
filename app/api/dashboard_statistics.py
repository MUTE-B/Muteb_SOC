
from flask import Blueprint,jsonify

from app.dashboard.statistics import statistics

dashboard_statistics=Blueprint(
    "dashboard_statistics",
    __name__
)

@dashboard_statistics.route("/statistics")
def stats():

    return jsonify(
        statistics()
    )
