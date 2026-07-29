

from flask import Blueprint,jsonify,request


from app.enterprise.rbac.access import AccessControl



rbac_api=Blueprint(

"enterprise_rbac",

__name__,

url_prefix="/api/enterprise"

)




@rbac_api.route("/permission",methods=["POST"])
def permission():


    data=request.json or {}


    return jsonify(

    AccessControl().check(

    data.get("role"),

    data.get("permission")

    )

    )



@rbac_api.route("/roles")
def roles():


    from app.enterprise.rbac.roles import RoleManager


    return jsonify(

    RoleManager.roles

    )



