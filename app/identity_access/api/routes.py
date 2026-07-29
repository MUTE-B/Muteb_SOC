

from flask import Blueprint,jsonify


from app.identity_access.users.manager import UserManager

from app.identity_access.rbac.engine import RBACEngine

from app.identity_access.policies.security import AccessPolicy



identity_api=Blueprint(

"identity_access",

__name__,

url_prefix="/api/identity"

)



users=UserManager()

rbac=RBACEngine()

policy=AccessPolicy()



@identity_api.route("/users")
def users_list():

    return jsonify(

    users.list_users()

    )



@identity_api.route("/roles")
def roles():

    return jsonify(

    rbac.get_roles()

    )



@identity_api.route("/policy")
def security_policy():

    return jsonify(

    policy.evaluate()

    )



