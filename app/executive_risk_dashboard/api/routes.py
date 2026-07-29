

from flask import Blueprint,jsonify


from app.executive_risk_dashboard.risk.engine import ExecutiveRiskEngine

from app.executive_risk_dashboard.kpi.metrics import ExecutiveKPI

from app.executive_risk_dashboard.compliance.status import ComplianceStatus

from app.executive_risk_dashboard.business.impact import BusinessImpact



executive_api=Blueprint(

"executive_dashboard",

__name__,

url_prefix="/api/executive"

)



risk=ExecutiveRiskEngine()

kpi=ExecutiveKPI()

compliance=ComplianceStatus()

business=BusinessImpact()



@executive_api.route("/risk")
def risk_view():


    return jsonify(

    risk.calculate()

    )





@executive_api.route("/kpi")
def kpi_view():


    return jsonify(

    kpi.dashboard()

    )





@executive_api.route("/compliance")
def compliance_view():


    return jsonify(

    compliance.check()

    )





@executive_api.route("/business")
def business_view():


    return jsonify(

    business.analyze()

    )



