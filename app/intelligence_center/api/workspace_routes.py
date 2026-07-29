

from flask import Blueprint,jsonify



from app.intelligence_center.workspace.analyst import AnalystWorkspace

from app.intelligence_center.workspace.incident_response import IncidentResponse



workspace_api=Blueprint(

"analyst_workspace",

__name__,

url_prefix="/api/intelligence"

)




@workspace_api.route("/workspace")
def workspace():


    return jsonify(

    AnalystWorkspace().overview()

    )




@workspace_api.route("/queue")
def queue():


    return jsonify(

    AnalystWorkspace().priority_queue()

    )




@workspace_api.route("/incident-workflow")
def workflow():


    return jsonify(

    IncidentResponse().workflow()

    )



