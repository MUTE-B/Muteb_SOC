

from flask import Blueprint,jsonify,request


from app.enterprise.tenant.organization import Organization

from app.enterprise.audit.audit_store import EnterpriseAudit



tenant_api=Blueprint(

"tenant_management",

__name__,

url_prefix="/api/enterprise"

)




org_manager=Organization()

audit=EnterpriseAudit()



@tenant_api.route("/organization",methods=["POST"])
def create_org():


    data=request.json or {}


    org=org_manager.create(

    data.get("name"),

    data.get("industry")

    )


    audit.record(

    "system",

    "CREATE_ORGANIZATION",

    org["name"]

    )


    return jsonify(org)




@tenant_api.route("/organizations")
def organizations():


    return jsonify(

    org_manager.list()

    )




@tenant_api.route("/audit")
def audit_logs():


    return jsonify(

    audit.history()

    )



