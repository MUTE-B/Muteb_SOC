

from flask import Blueprint,jsonify


from app.api_gateway.services.registry import ServiceRegistry

from app.api_gateway.security.security import APISecurity

from app.api_gateway.routes.router import APIRouter



gateway_api=Blueprint(

"api_gateway",

__name__,

url_prefix="/api/gateway"

)



registry=ServiceRegistry()

security=APISecurity()

router=APIRouter()



@gateway_api.route("/services")
def services():

    return jsonify(

    registry.services()

    )



@gateway_api.route("/security")
def api_security():

    return jsonify(

    security.validate()

    )



@gateway_api.route("/connect/<service>")
def connect(service):

    return jsonify(

    router.route(service)

    )



