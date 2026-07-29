

from flask import Blueprint,jsonify


from app.v70.cloud.platform import SecurityCloud

from app.v70.ai_cloud.core import AISecurityCloud

from app.v70.api_economy.core import APIPlatform

from app.v70.operations.core import GlobalOperations



cloud_api=Blueprint(

"security_cloud",

__name__,

url_prefix="/api/v70"

)



cloud=SecurityCloud()

ai=AISecurityCloud()

apis=APIPlatform()

operations=GlobalOperations()



@cloud_api.route("/cloud")
def cloud_view():

    return jsonify(cloud.status())


@cloud_api.route("/ai")
def ai_view():

    return jsonify(ai.intelligence())


@cloud_api.route("/apis")
def api_view():

    return jsonify(apis.services())


@cloud_api.route("/operations")
def operations_view():

    return jsonify(operations.monitor())



