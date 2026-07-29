

from flask import Blueprint,jsonify,request


from app.zero_trust_identity.users.manager import UserManager

from app.zero_trust_identity.rbac.engine import RBACEngine

from app.zero_trust_identity.policy.engine import ZeroTrustPolicy

from app.zero_trust_identity.auth.service import AuthenticationService



zt_api=Blueprint(

"zero_trust_identity",

__name__,

url_prefix="/api/zero-trust"

)



users=UserManager()

rbac=RBACEngine()

policy=ZeroTrustPolicy()

auth=AuthenticationService()



@zt_api.route("/user",methods=["POST"])
def create_user():


    data=request.json or {}


    return jsonify(

    users.create(

    data.get("name"),

    data.get("role")

    )

    )





@zt_api.route("/users")
def list_users():


    return jsonify(

    users.list()

    )





@zt_api.route("/permissions/<role>")
def permissions(role):


    return jsonify(

    rbac.permissions(

    role.upper()

    )

    )





@zt_api.route("/access",methods=["POST"])
def access_check():


    data=request.json or {}


    return jsonify(

    policy.evaluate(

    data.get("user"),

    data.get("device")

    )

    )





@zt_api.route("/login/<user>")
def login(user):


    return jsonify(

    auth.verify(user)

    )



