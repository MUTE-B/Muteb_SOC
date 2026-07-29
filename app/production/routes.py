

from flask import Blueprint,jsonify


from app.production.monitoring.health import SystemHealth


production_api=Blueprint(

"production",

__name__,

url_prefix="/api/system"

)




@production_api.route("/health")
def health():


    return jsonify(

    SystemHealth().status()

    )




@production_api.route("/version")
def version():


    return jsonify({


    "platform":

    "MUTEB SOC Enterprise",


    "edition":

    "Government Grade",


    "status":

    "READY"



    })



