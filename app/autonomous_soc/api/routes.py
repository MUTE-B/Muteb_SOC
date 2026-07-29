

from flask import Blueprint,jsonify,request


from app.autonomous_soc.decision.engine import AIDecisionEngine

from app.autonomous_soc.playbooks.engine import SecurityPlaybook

from app.autonomous_soc.response.engine import AutomatedResponse



auto_api=Blueprint(

"autonomous_soc",

__name__,

url_prefix="/api/autonomous-soc"

)



decision=AIDecisionEngine()

playbook=SecurityPlaybook()

response=AutomatedResponse()



@auto_api.route("/execute",methods=["POST"])
def execute():


    data=request.json or {}


    result=decision.decide(

    data.get("event")

    )


    workflow=playbook.execute(

    result["decision"]

    )


    final=response.run(

    result["decision"]

    )


    return jsonify({


    "decision":result,


    "playbook":workflow,


    "response":final



    })



