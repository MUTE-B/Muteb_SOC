

from flask import Blueprint,jsonify


from app.sentinel_x.core.controller import SentinelController



final_api=Blueprint(

"sentinel_final",

__name__,

url_prefix="/api/sentinel"

)




@final_api.route("/enterprise-status")
def enterprise_status():


    return jsonify(

        SentinelController().status()

    )



@final_api.route("/health")
def health():


    return jsonify({


    "name":

    "MUTEB SOC Sentinel X",


    "edition":

    "Enterprise",


    "status":

    "Running"


    })



