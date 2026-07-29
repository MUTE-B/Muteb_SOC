

from flask import Blueprint,jsonify


from app.v33.automation.engine import AutomationEngine

from app.v33.playbooks.engine import AIPlaybooks

from app.v33.response.engine import IncidentResponse

from app.v33.self_healing.engine import SelfHealing



auto_api=Blueprint(

"autonomous_soc",

__name__,

url_prefix="/api/v33"

)



automation=AutomationEngine()

playbooks=AIPlaybooks()

response=IncidentResponse()

healing=SelfHealing()



@auto_api.route("/automation")
def automation_view():

    return jsonify(automation.execute())


@auto_api.route("/playbooks")
def playbooks_view():

    return jsonify(playbooks.run())


@auto_api.route("/response")
def response_view():

    return jsonify(response.respond())


@auto_api.route("/healing")
def healing_view():

    return jsonify(healing.repair())


