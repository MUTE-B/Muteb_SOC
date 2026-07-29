

from flask import Blueprint,jsonify,request


from app.sentinel_x.workflow.assessment import AssessmentWorkflow

from app.sentinel_x.workflow.authorization import AuthorizationControl

from app.sentinel_x.workflow.audit import AuditLogger




workflow_api=Blueprint(

"sentinel_workflow",

__name__,

url_prefix="/api/sentinel"

)




audit=AuditLogger()



@workflow_api.route("/authorize",methods=["POST"])
def authorize():


    data=request.json or {}


    result=AuthorizationControl().verify(

        data.get("organization"),

        data.get("asset"),

        data.get("approval_id")

    )


    audit.record(

        "Security Analyst",

        "Authorization Request",

        data.get("asset")

    )


    return jsonify(result)






@workflow_api.route("/run-assessment",methods=["POST"])
def run_assessment():


    data=request.json or {}


    result=AssessmentWorkflow().run(

        data.get("target")

    )


    audit.record(

        "Security Analyst",

        "Assessment Started",

        data.get("target")

    )


    return jsonify(result)






@workflow_api.route("/audit-log")
def audit_log():


    return jsonify(

        audit.all()

    )



