

from flask import Blueprint,jsonify


from app.continuous_monitoring.health.score import SecurityHealth

from app.continuous_monitoring.trends.history import RiskTrend

from app.continuous_monitoring.maturity.model import SecurityMaturity



monitor_api=Blueprint(

"continuous_monitoring",

__name__,

url_prefix="/api/monitoring"

)



health=SecurityHealth()

trend=RiskTrend()

maturity=SecurityMaturity()



@monitor_api.route("/health")
def health_status():


    return jsonify(

    health.calculate()

    )





@monitor_api.route("/trend")
def risk_trend():


    return jsonify(

    trend.report()

    )





@monitor_api.route("/maturity")
def maturity_status():


    return jsonify(

    maturity.evaluate()

    )



