

from flask import Blueprint,jsonify


from app.audit_governance.logs.logger import AuditLogger

from app.audit_governance.tracking.changes import ChangeTracker

from app.audit_governance.compliance.engine import ComplianceEngine



audit_api=Blueprint(

"audit_governance",

__name__,

url_prefix="/api/audit"

)



logger=AuditLogger()

tracker=ChangeTracker()

compliance=ComplianceEngine()



@audit_api.route("/log")
def log():

    return jsonify(

    logger.record(

    "Security Review",

    "Administrator"

    )

    )



@audit_api.route("/changes")
def changes():

    return jsonify(

    tracker.history()

    )



@audit_api.route("/compliance")
def compliance_check():

    return jsonify(

    compliance.evaluate()

    )



