

from flask import Blueprint,jsonify,request


from app.intelligence_engine.assets.asset_manager import AssetManager

from app.intelligence_engine.risk.risk_engine import RiskEngine

from app.intelligence_engine.reports.report_engine import SecurityReport



intel_api=Blueprint(

"intelligence",

__name__,

url_prefix="/api/intelligence"

)



assets=AssetManager()

risk_engine=RiskEngine()

report=SecurityReport()



@intel_api.route("/asset",methods=["POST"])
def asset():


    data=request.json or {}


    return jsonify(

    assets.register(

    data.get("target"),

    data.get("organization")

    )

    )




@intel_api.route("/assets")
def asset_list():


    return jsonify(

    assets.list()

    )




@intel_api.route("/assessment",methods=["POST"])
def assessment():


    data=request.json or {}


    findings=data.get(

    "findings",

    []

    )



    risk=risk_engine.calculate(findings)



    return jsonify(

    report.generate(

    data.get("target"),

    risk

    )

    )



