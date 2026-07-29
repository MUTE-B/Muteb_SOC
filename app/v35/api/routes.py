

from flask import Blueprint,jsonify


from app.v35.simulation.engine import AttackSimulation

from app.v35.training.lab import SecurityTrainingLab

from app.v35.purple_team.workflow import PurpleTeam

from app.v35.scenarios.library import ScenarioLibrary



range_api=Blueprint(

"cyber_range",

__name__,

url_prefix="/api/v35"

)



simulation=AttackSimulation()

training=SecurityTrainingLab()

purple=PurpleTeam()

scenarios=ScenarioLibrary()



@range_api.route("/simulation")
def simulation_view():

    return jsonify(simulation.run())


@range_api.route("/training")
def training_view():

    return jsonify(training.modules())


@range_api.route("/purple-team")
def purple_view():

    return jsonify(purple.exercise())


@range_api.route("/scenarios")
def scenarios_view():

    return jsonify(scenarios.list())


