

from flask import Blueprint,jsonify,request


from app.security_layer.core.rbac import RoleManager

from app.security_layer.core.audit import SecurityAudit

from app.security_layer.core.config import EnterpriseConfig



security_api=Blueprint(

"security_layer",

__name__,

url_prefix="/api/security"

)



roles=RoleManager()

audit=SecurityAudit()

config=EnterpriseConfig()



@security_api.route("/role/<role>")
def role(role):


    return jsonify(

    {

    "role":role,

    "permissions":

    roles.permissions(role)

    }

    )





@security_api.route("/audit",methods=["POST"])
def create_audit():


    data=request.json or {}


    return jsonify(

    audit.record(

    data.get("user"),

    data.get("action")

    )

    )





@security_api.route("/config")
def get_config():


    return jsonify(

    config.get()

    )



