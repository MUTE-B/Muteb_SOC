

from flask import Blueprint,jsonify


from app.soar_center.playbooks.engine import PlaybookEngine

from app.soar_center.orchestration.engine import OrchestrationEngine

from app.soar_center.response.manager import AutomatedResponse



soar_api=Blueprint(

"soar_center",

__name__,

url_prefix="/api/soar"

)



playbooks=PlaybookEngine()

orchestrator=OrchestrationEngine()

response=AutomatedResponse()



@soar_api.route("/playbooks")
def playbook_view():

    return jsonify(

    playbooks.list()

    )



@soar_api.route("/execute")
def execute():

    return jsonify(

    orchestrator.execute(

    "Threat Containment"

    )

    )



@soar_api.route("/response")
def response_view():

    return jsonify(

    response.respond()

    )



