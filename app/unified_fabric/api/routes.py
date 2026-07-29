

from flask import Blueprint,jsonify


from app.unified_fabric.core.registry import EnterpriseRegistry

from app.unified_fabric.intelligence.engine import IntelligenceEngine

from app.unified_fabric.orchestration.fabric import IntelligenceFabric



fabric_api=Blueprint(

"unified_fabric",

__name__,

url_prefix="/api/fabric"

)



registry=EnterpriseRegistry()

intel=IntelligenceEngine()

fabric=IntelligenceFabric()



@fabric_api.route("/modules")
def modules():

    return jsonify(

    registry.modules()

    )



@fabric_api.route("/intelligence")
def intelligence():

    return jsonify(

    intel.analyze()

    )



@fabric_api.route("/status")
def status():

    return jsonify(

    fabric.status()

    )



