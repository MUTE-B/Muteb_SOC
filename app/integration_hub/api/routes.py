

from flask import Blueprint,jsonify


from app.integration_hub.core.registry import ModuleRegistry

from app.integration_hub.health.check import PlatformHealth



integration_api=Blueprint(

"integration_hub",

__name__,

url_prefix="/api/platform"

)



registry=ModuleRegistry()

health=PlatformHealth()



@integration_api.route("/status")
def status():


    return jsonify(

    registry.status()

    )





@integration_api.route("/health")
def health_status():


    return jsonify(

    health.check()

    )



