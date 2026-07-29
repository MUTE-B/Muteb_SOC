

from flask import Blueprint,jsonify


from app.security_digital_twin.environment.model import DigitalEnvironment

from app.security_digital_twin.simulation.engine import AttackSimulation

from app.security_digital_twin.scenarios.library import ScenarioLibrary



twin_api=Blueprint(

"security_digital_twin",

__name__,

url_prefix="/api/digital-twin"

)



environment=DigitalEnvironment()

simulation=AttackSimulation()

scenarios=ScenarioLibrary()



@twin_api.route("/status")
def environment_status():

    return jsonify(

    environment.status()

    )



@twin_api.route("/simulate")
def simulate():

    return jsonify(

    simulation.run(

    "Ransomware Attack"

    )

    )



@twin_api.route("/scenarios")
def scenario_list():

    return jsonify(

    scenarios.scenarios()

    )



