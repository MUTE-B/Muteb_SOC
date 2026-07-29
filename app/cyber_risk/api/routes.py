

from flask import Blueprint,jsonify


from app.cyber_risk.risk_register.manager import RiskRegister

from app.cyber_risk.scoring.engine import RiskScoring

from app.cyber_risk.remediation.tracker import RemediationTracker



risk_api=Blueprint(

"cyber_risk",

__name__,

url_prefix="/api/risk"

)



register=RiskRegister()

score=RiskScoring()

remediation=RemediationTracker()



@risk_api.route("/register")
def risk_register():

    return jsonify(

    register.list()

    )



@risk_api.route("/score")
def risk_score():

    return jsonify(

    score.calculate()

    )



@risk_api.route("/remediation")
def remediation_status():

    return jsonify(

    remediation.status()

    )



