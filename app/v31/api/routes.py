

from flask import Blueprint,jsonify


from app.v31.database.db import Database

from app.v31.users.auth import UserManager

from app.v31.tenant.core import TenantManager



upgrade_api=Blueprint(

"upgrade",

__name__,

url_prefix="/api/v31"

)



db=Database()

users=UserManager()

tenant=TenantManager()



@upgrade_api.route("/database")
def database():

    return jsonify(db.status())



@upgrade_api.route("/users")
def user():

    return jsonify(users.users())



@upgrade_api.route("/tenant")
def tenant_view():

    return jsonify(tenant.tenants())



