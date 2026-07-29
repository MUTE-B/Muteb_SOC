

from flask import Blueprint,jsonify


from app.core.engine import MutebCore

from app.core.registry import ModuleRegistry

from app.soc_fusion.dashboard import SOCFusion


master_api=Blueprint(

"master",

__name__,

url_prefix="/api/master"

)


core=MutebCore()

registry=ModuleRegistry()

soc=SOCFusion()



@master_api.route("/status")

def status():

    return jsonify(

    core.status()

    )



@master_api.route("/modules")

def modules():

    return jsonify(

    registry.modules()

    )



@master_api.route("/soc")

def soc_status():

    return jsonify(

    soc.overview()

    )



