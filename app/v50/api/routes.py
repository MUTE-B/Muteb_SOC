

from flask import Blueprint,jsonify


from app.v50.agents.core import SecurityAgents

from app.v50.intelligence.core import FutureIntelligence

from app.v50.learning.engine import LearningEngine

from app.v50.assets.intelligence import AssetIntelligence



future_api=Blueprint(

"future_security",

__name__,

url_prefix="/api/v50"

)



agents=SecurityAgents()

intel=FutureIntelligence()

learning=LearningEngine()

assets=AssetIntelligence()



@future_api.route("/agents")
def agents_view():

    return jsonify(agents.status())


@future_api.route("/intelligence")
def intelligence_view():

    return jsonify(intel.analyze())


@future_api.route("/learning")
def learning_view():

    return jsonify(learning.train())


@future_api.route("/assets")
def assets_view():

    return jsonify(assets.discover())


