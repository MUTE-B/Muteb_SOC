

from flask import Blueprint,jsonify


from app.v80.autonomous_soc.core import AutonomousSOC

from app.v80.agents.network import AgentNetwork

from app.v80.learning.model import DefenseLearning

from app.v80.brain.core import GlobalSecurityBrain



auto_api=Blueprint(

"autonomous_network",

__name__,

url_prefix="/api/v80"

)



soc=AutonomousSOC()

agents=AgentNetwork()

learning=DefenseLearning()

brain=GlobalSecurityBrain()



@auto_api.route("/soc")
def soc_view():

    return jsonify(soc.operate())


@auto_api.route("/agents")
def agents_view():

    return jsonify(agents.status())


@auto_api.route("/learning")
def learning_view():

    return jsonify(learning.improve())


@auto_api.route("/brain")
def brain_view():

    return jsonify(brain.analyze())



