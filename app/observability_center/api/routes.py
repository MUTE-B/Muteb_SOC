

from flask import Blueprint,jsonify


from app.observability_center.metrics.collector import MetricsCollector

from app.observability_center.logs.manager import LogManager

from app.observability_center.monitoring.engine import MonitoringEngine



observe_api=Blueprint(

"observability",

__name__,

url_prefix="/api/observability"

)



metrics=MetricsCollector()

logs=LogManager()

monitor=MonitoringEngine()



@observe_api.route("/metrics")
def metrics_view():

    return jsonify(

    metrics.collect()

    )



@observe_api.route("/logs")
def logs_view():

    return jsonify(

    logs.collect()

    )



@observe_api.route("/status")
def status_view():

    return jsonify(

    monitor.status()

    )



