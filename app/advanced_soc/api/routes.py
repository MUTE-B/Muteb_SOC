

from flask import Blueprint,jsonify,request


from app.advanced_soc.core.events import SecurityEventEngine

from app.advanced_soc.core.risk_map import RiskHeatMap

from app.advanced_soc.core.workspace import AnalystWorkspace



advanced_api=Blueprint(

"advanced_soc",

__name__,

url_prefix="/api/advanced-soc"

)



events=SecurityEventEngine()

risk=RiskHeatMap()

workspace=AnalystWorkspace()



@advanced_api.route("/events",methods=["POST"])
def create_event():


    data=request.json or {}


    return jsonify(

    events.add_event(

    data.get("type"),

    data.get("severity"),

    data.get("source")

    )

    )





@advanced_api.route("/timeline")
def timeline():


    return jsonify(

    events.timeline()

    )





@advanced_api.route("/risk-map")
def risk_map():


    return jsonify(

    risk.generate()

    )





@advanced_api.route("/workspace")
def analyst_workspace():


    return jsonify(

    workspace.status()

    )



