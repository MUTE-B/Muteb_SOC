

from flask import Blueprint,jsonify


from app.threat_simulation.attacks.scenarios import AttackSimulation

from app.threat_simulation.detection.testing import DetectionTesting

from app.threat_simulation.purple_team.lab import PurpleTeamLab



simulation_api=Blueprint(

"threat_simulation",

__name__,

url_prefix="/api/threat-simulation"

)



attack=AttackSimulation()

detect=DetectionTesting()

purple=PurpleTeamLab()



@simulation_api.route("/scenarios")
def scenarios():

    return jsonify(

    attack.list()

    )



@simulation_api.route("/detection")
def detection():

    return jsonify(

    detect.run()

    )



@simulation_api.route("/purple-team")
def purple_team():

    return jsonify(

    purple.execute()

    )



