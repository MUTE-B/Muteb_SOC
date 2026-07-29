

from flask import Blueprint,jsonify,request



from app.command_center.core.dashboard import SOCCommandCenter

from app.command_center.core.incident_manager import IncidentManager




command_api=Blueprint(

"command_center",

__name__,

url_prefix="/api/command"

)




@command_api.route("/overview")
def overview():


    return jsonify(

    SOCCommandCenter().overview()

    )





@command_api.route("/executive")
def executive():


    return jsonify(

    SOCCommandCenter().executive_view()

    )





@command_api.route("/incident",methods=["POST"])
def incident():


    data=request.json or {}


    return jsonify(

    IncidentManager().create(

    data.get("title","Unknown")

    )

    )



