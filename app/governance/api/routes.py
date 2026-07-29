

from flask import Blueprint,jsonify


from app.governance.dfir.engine import DFIREngine

from app.governance.risk.engine import RiskEngine

from app.governance.compliance.engine import ComplianceEngine

from app.governance.zero_trust.engine import ZeroTrustEngine

from app.governance.cloud.engine import CloudSecurity

from app.governance.vulnerability.engine import VulnerabilityManager



gov_api=Blueprint(

"governance",

__name__,

url_prefix="/api/governance"

)



dfir=DFIREngine()

risk=RiskEngine()

compliance=ComplianceEngine()

zt=ZeroTrustEngine()

cloud=CloudSecurity()

vuln=VulnerabilityManager()



@gov_api.route("/dfir")
def dfir_view():

    return jsonify(dfir.investigate())



@gov_api.route("/risk")
def risk_view():

    return jsonify(risk.calculate())



@gov_api.route("/compliance")
def compliance_view():

    return jsonify(compliance.audit())



@gov_api.route("/zero-trust")
def zero_view():

    return jsonify(zt.verify())



@gov_api.route("/cloud")
def cloud_view():

    return jsonify(cloud.monitor())



@gov_api.route("/vulnerability")
def vuln_view():

    return jsonify(vuln.scan())



