

from flask import Blueprint,jsonify


from app.identity_governance.users.manager import UserManager

from app.identity_governance.roles.rbac import RoleManager

from app.identity_governance.risk.analyzer import IdentityRisk



identity_api=Blueprint(

"identity_governance",

__name__,

url_prefix="/api/identity"

)



users=UserManager()

roles=RoleManager()

risk=IdentityRisk()



@identity_api.route("/users")
def users_view():

    return jsonify(

    users.users()

    )



@identity_api.route("/roles")
def roles_view():

    return jsonify(

    roles.roles()

    )



@identity_api.route("/risk")
def risk_view():

    return jsonify(

    risk.analyze()

    )



