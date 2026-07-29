

from flask import Blueprint,jsonify


from app.security_audit.checks.engine import SecurityAudit

from app.security_audit.report.score import ReadinessScore



audit_api=Blueprint(

"security_audit",

__name__,

url_prefix="/api/audit"

)



audit=SecurityAudit()

score=ReadinessScore()



@audit_api.route("/security")
def security_check():


    return jsonify(

    audit.run()

    )





@audit_api.route("/readiness")
def readiness():


    return jsonify(

    score.calculate()

    )



