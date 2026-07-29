

from flask import Blueprint,jsonify,request



intel_api=Blueprint(

"intelligence_center",

__name__,

url_prefix="/api/intelligence"

)




@intel_api.route("/status")
def status():


    return jsonify({


    "platform":

    "MUTEB Intelligence Center",


    "status":

    "ACTIVE"



    })




@intel_api.route("/asset",methods=["POST"])
def asset():


    data=request.json or {}


    return jsonify({


    "asset":

    data.get("name"),


    "status":

    "MONITORED"



    })




@intel_api.route("/incident",methods=["POST"])
def incident():


    data=request.json or {}


    return jsonify({


    "incident":

    data.get("name"),


    "status":

    "CREATED"



    })



