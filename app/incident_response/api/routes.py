

from flask import Blueprint,jsonify,request


from app.incident_response.cases.manager import CaseManager

from app.incident_response.investigation.engine import InvestigationEngine

from app.incident_response.response.workflow import ResponseWorkflow



incident_api=Blueprint(

"incident_response",

__name__,

url_prefix="/api/incidents"

)



cases=CaseManager()

investigation=InvestigationEngine()

response=ResponseWorkflow()



@incident_api.route("/",methods=["POST"])
def create_case():


    data=request.json or {}


    return jsonify(

    cases.create(

    data.get("title"),

    data.get("severity")

    )

    )





@incident_api.route("/")
def get_cases():


    return jsonify(

    cases.list()

    )





@incident_api.route("/investigate/<case_id>")
def investigate(case_id):


    return jsonify(

    investigation.analyze(case_id)

    )





@incident_api.route("/respond",methods=["POST"])
def respond():


    data=request.json or {}


    return jsonify(

    response.execute(

    data.get("action")

    )

    )



