

from flask import Blueprint,jsonify


from config.environment import EnvironmentConfig



security_api=Blueprint(

"security",

__name__,

url_prefix="/api/security"

)




@security_api.route("/status")
def status():


    return jsonify(

    EnvironmentConfig.status()

    )



