

from flask import Blueprint,jsonify


from app.purple_team.simulation.engine import AttackSimulator

from app.purple_team.mitre.mapping import MITREMapper

from app.purple_team.detection.tester import DetectionTester

from app.purple_team.improvement.engine import DefenseImprovement



purple_api=Blueprint(

"purple_team",

__name__,

url_prefix="/api/purple-team"

)



simulation=AttackSimulator()

mitre=MITREMapper()

detection=DetectionTester()

improve=DefenseImprovement()



@purple_api.route("/simulate/<scenario>")
def simulate(scenario):


    return jsonify(

    simulation.run(

    scenario

    )

    )





@purple_api.route("/mitre/<name>")
def mitre_map(name):


    return jsonify(

    mitre.get(

    name

    )

    )





@purple_api.route("/detection")
def detection_test():


    return jsonify(

    detection.test()

    )





@purple_api.route("/improvement")
def improvement():


    return jsonify(

    improve.analyze()

    )



