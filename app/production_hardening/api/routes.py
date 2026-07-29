

from flask import Blueprint,jsonify


from app.production_hardening.security.baseline import SecurityBaseline

from app.production_hardening.config.review import ConfigurationReview

from app.production_hardening.audit.engine import SecurityAudit

from app.production_hardening.compliance.check import ComplianceBaseline



hardening_api=Blueprint(

"production_hardening",

__name__,

url_prefix="/api/hardening"

)



security=SecurityBaseline()

config=ConfigurationReview()

audit=SecurityAudit()

compliance=ComplianceBaseline()



@hardening_api.route("/security")
def security_check():


    return jsonify(

    security.scan()

    )





@hardening_api.route("/config")
def config_check():


    return jsonify(

    config.check()

    )





@hardening_api.route("/audit")
def audit_report():


    return jsonify(

    audit.generate()

    )





@hardening_api.route("/compliance")
def compliance_check():


    return jsonify(

    compliance.verify()

    )



