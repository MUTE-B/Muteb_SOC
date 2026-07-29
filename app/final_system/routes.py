

from flask import Blueprint,jsonify


from app.final_system.controller import MutebEnterpriseController



final_api=Blueprint(

"final_system",

__name__,

url_prefix="/api/system"

)



system=MutebEnterpriseController()



@final_api.route("/health")

def health():

    return jsonify(

    system.health_check()

    )



@final_api.route("/modules")

def modules():

    return jsonify(

    system.modules()

    )



