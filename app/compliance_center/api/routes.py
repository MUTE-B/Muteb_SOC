

from flask import Blueprint,jsonify


from app.compliance_center.audit.manager import AuditManager

from app.compliance_center.frameworks.registry import ComplianceFrameworks

from app.compliance_center.evidence.collector import EvidenceCollector



compliance_api=Blueprint(

"compliance_center",

__name__,

url_prefix="/api/compliance"

)



audit=AuditManager()

frameworks=ComplianceFrameworks()

evidence=EvidenceCollector()



@compliance_api.route("/audit")
def audit_view():

    return jsonify(

    audit.audits()

    )



@compliance_api.route("/frameworks")
def framework_view():

    return jsonify(

    frameworks.list()

    )



@compliance_api.route("/evidence")
def evidence_view():

    return jsonify(

    evidence.collect()

    )



