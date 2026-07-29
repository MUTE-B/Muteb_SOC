

from flask import Blueprint,jsonify


from app.security_automation.playbooks.library import PlaybookLibrary

from app.security_automation.workflows.engine import WorkflowEngine

from app.security_automation.actions.actions import SecurityActions



automation_api=Blueprint(

"security_automation",

__name__,

url_prefix="/api/automation"

)



library=PlaybookLibrary()

workflow=WorkflowEngine()

actions=SecurityActions()



@automation_api.route("/playbooks")
def playbooks():

    return jsonify(

    library.list()

    )



@automation_api.route("/execute")
def execute_workflow():

    return jsonify(

    workflow.execute(

    "Incident Response"

    )

    )



@automation_api.route("/actions")
def security_actions():

    return jsonify(

    actions.execute()

    )



