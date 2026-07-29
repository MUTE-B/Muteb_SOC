

from flask import Blueprint,jsonify,request


from app.grc_center.controls.engine import SecurityControls

from app.grc_center.risk.register import RiskRegister

from app.grc_center.evidence.manager import EvidenceManager

from app.grc_center.compliance.scoring import ComplianceScore



grc_api=Blueprint(

"grc_center",

__name__,

url_prefix="/api/grc"

)



controls=SecurityControls()

risks=RiskRegister()

evidence=EvidenceManager()

score=ComplianceScore()



@grc_api.route("/controls")
def control_status():


    return jsonify(

    controls.status()

    )





@grc_api.route("/risk",methods=["POST"])
def add_risk():


    data=request.json or {}


    return jsonify(

    risks.add(

    data.get("name"),

    data.get("level")

    )

    )





@grc_api.route("/risks")
def risks_list():


    return jsonify(

    risks.list()

    )





@grc_api.route("/score")
def compliance_score():


    return jsonify(

    score.calculate()

    )





@grc_api.route("/evidence",methods=["POST"])
def add_evidence():


    data=request.json or {}


    return jsonify(

    evidence.upload(

    data.get("item")

    )

    )



