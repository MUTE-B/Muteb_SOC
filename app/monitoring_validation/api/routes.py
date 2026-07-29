

from flask import Blueprint,jsonify


from app.monitoring_validation.health.check import MonitoringHealth

from app.monitoring_validation.performance.check import PerformanceValidation

from app.monitoring_validation.alerts.engine import AlertValidation



monitor_api=Blueprint(

"monitor_validation",

__name__,

url_prefix="/api/monitor-validation"

)



health=MonitoringHealth()

performance=PerformanceValidation()

alerts=AlertValidation()



@monitor_api.route("/health")
def health():

    return jsonify(

    health.validate()

    )



@monitor_api.route("/performance")
def performance():

    return jsonify(

    performance.analyze()

    )



@monitor_api.route("/alerts")
def alert_check():

    return jsonify(

    alerts.test()

    )


