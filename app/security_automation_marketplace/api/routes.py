

from flask import Blueprint,jsonify


from app.security_automation_marketplace.playbooks.library import PlaybookLibrary

from app.security_automation_marketplace.actions.engine import AutomationActions

from app.security_automation_marketplace.integrations.catalog import IntegrationCatalog

from app.security_automation_marketplace.governance.control import AutomationGovernance



automation_api=Blueprint(

"security_automation",

__name__,

url_prefix="/api/security-automation"

)



playbooks=PlaybookLibrary()

actions=AutomationActions()

integrations=IntegrationCatalog()

governance=AutomationGovernance()



@automation_api.route("/playbooks")
def list_playbooks():


    return jsonify(

    playbooks.list()

    )





@automation_api.route("/execute/<action>")
def execute_action(action):


    return jsonify(

    actions.execute(

    action

    )

    )





@automation_api.route("/integrations")
def integrations_list():


    return jsonify(

    integrations.list()

    )





@automation_api.route("/governance")
def governance_status():


    return jsonify(

    governance.status()

    )



