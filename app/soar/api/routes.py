

from flask import Blueprint,jsonify,request


from app.soar.playbooks.engine import PlaybookEngine

from app.soar.automation.actions import AutomationActions

from app.soar.workflow.workflow import WorkflowEngine



soar_api=Blueprint(

"soar",

__name__,

url_prefix="/api/soar"

)



playbook=PlaybookEngine()

actions=AutomationActions()

workflow=WorkflowEngine()



@soar_api.route("/playbook",methods=["POST"])
def run_playbook():


    return jsonify(

    playbook.execute(

    request.json or {}

    )

    )





@soar_api.route("/action",methods=["POST"])
def execute_action():


    data=request.json or {}


    return jsonify(

    actions.run(

    data.get("action")

    )

    )





@soar_api.route("/workflow")
def get_workflow():


    return jsonify(

    workflow.process()

    )



