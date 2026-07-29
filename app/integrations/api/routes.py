

from flask import Blueprint,jsonify,request


from app.integrations.siem.connector import SIEMConnector

from app.integrations.threat_intel.intelligence import ThreatIntelligence

from app.integrations.vulnerability.cve_engine import CVEEngine



integration_api=Blueprint(

"integrations",

__name__,

url_prefix="/api/integrations"

)



siem=SIEMConnector()

intel=ThreatIntelligence()

cve=CVEEngine()



@integration_api.route("/siem")
def siem_status():


    return jsonify(

    siem.status()

    )





@integration_api.route("/threat",methods=["POST"])
def threat_check():


    data=request.json or {}


    return jsonify(

    intel.analyze(

    data.get("indicator")

    )

    )





@integration_api.route("/cve",methods=["POST"])
def cve_check():


    data=request.json or {}


    return jsonify(

    cve.analyze(

    data.get("cve")

    )

    )



