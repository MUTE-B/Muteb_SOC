

from flask import Blueprint,jsonify


from app.v40.core.platform import MutebCyberOS

from app.v40.security.center import SecurityCenter

from app.v40.brain.core import EnterpriseAI

from app.v40.enterprise.control import EnterpriseControl



final_api=Blueprint(

"muteb_v40",

__name__,

url_prefix="/api/v40"

)



os=MutebCyberOS()

security=SecurityCenter()

ai=EnterpriseAI()

enterprise=EnterpriseControl()



@final_api.route("/status")
def status():

    return jsonify(os.status())


@final_api.route("/security")
def security_view():

    return jsonify(security.modules())


@final_api.route("/ai")
def ai_view():

    return jsonify(ai.status())


@final_api.route("/enterprise")
def enterprise_view():

    return jsonify(enterprise.info())



