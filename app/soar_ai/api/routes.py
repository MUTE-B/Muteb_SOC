

from flask import Blueprint,jsonify,request


from app.soar_ai.playbooks.engine import SOARPlaybookEngine

from app.soar_ai.actions.response import AutomatedResponse

from app.soar_ai.decision.engine import AIResponseDecision



soar_ai_api=Blueprint(

"soar_ai",

__name__,

url_prefix="/api/soar-ai"

)



playbook=SOARPlaybookEngine()

response=AutomatedResponse()

decision=AIResponseDecision()



@soar_ai_api.route("/playbook/<incident>")
def execute_playbook(incident):


    return jsonify(

    playbook.execute(

    incident

    )

    )





@soar_ai_api.route("/action/<action>")
def action(action):


    return jsonify(

    response.run(

    action

    )

    )





@soar_ai_api.route("/decision",methods=["POST"])
def ai_decision():


    data=request.json or {}


    return jsonify(

    decision.decide(

    data.get("alert")

    )

    )



