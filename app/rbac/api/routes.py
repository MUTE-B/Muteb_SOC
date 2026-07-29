

from flask import Blueprint,jsonify,request


from app.rbac.users.manager import UserManager

from app.rbac.roles.engine import RoleEngine

from app.rbac.permissions.control import PermissionControl

from app.rbac.audit.logger import AuditLogger



rbac_api=Blueprint(

"rbac",

__name__,

url_prefix="/api/rbac"

)



users=UserManager()

roles=RoleEngine()

permissions=PermissionControl()

audit=AuditLogger()



@rbac_api.route("/users")
def user_list():


    return jsonify(

    users.list()

    )





@rbac_api.route("/user",methods=["POST"])
def create_user():


    data=request.json or {}


    result=users.create(

    data.get("name"),

    data.get("role")

    )


    audit.record(

    "CREATE_USER",

    data.get("name")

    )


    return jsonify(result)





@rbac_api.route("/role/<role>")
def role(role):


    return jsonify(

    roles.get(role)

    )





@rbac_api.route("/permission/<role>/<permission>")
def permission(role,permission):


    return jsonify(

    permissions.check(

    permission,

    role

    )

    )



