

from flask import Blueprint,jsonify


from deployment.config.environment import EnvironmentConfig

from deployment.services.manager import ServiceManager

from deployment.runtime.monitor import RuntimeMonitor



deployment_api=Blueprint(

"deployment",

__name__,

url_prefix="/api/deployment"

)



config=EnvironmentConfig()

services=ServiceManager()

monitor=RuntimeMonitor()



@deployment_api.route("/config")
def configuration():


    return jsonify(

    config.get()

    )





@deployment_api.route("/services")
def service_status():


    return jsonify(

    services.status()

    )





@deployment_api.route("/health")
def runtime_health():


    return jsonify(

    monitor.check()

    )



