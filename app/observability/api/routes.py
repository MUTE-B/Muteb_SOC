

from flask import Blueprint,jsonify


from app.observability.metrics.collector import MetricsCollector

from app.observability.health.checker import HealthChecker

from app.observability.performance.engine import PerformanceEngine



observe_api=Blueprint(

"observability",

__name__,

url_prefix="/api/observability"

)



metrics=MetricsCollector()

health=HealthChecker()

performance=PerformanceEngine()



@observe_api.route("/metrics")
def metrics_view():


    return jsonify(

    metrics.collect()

    )





@observe_api.route("/health")
def health_view():


    return jsonify(

    health.status()

    )





@observe_api.route("/performance")
def performance_view():


    return jsonify(

    performance.analyze()

    )



