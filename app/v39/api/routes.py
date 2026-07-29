

from flask import Blueprint,jsonify


from app.v39.brain.core import SecurityBrain

from app.v39.decision.engine import DecisionEngine

from app.v39.prediction.model import ThreatPrediction

from app.v39.recommendation.engine import RecommendationEngine



brain_api=Blueprint(

"ai_brain",

__name__,

url_prefix="/api/v39"

)



brain=SecurityBrain()

decision=DecisionEngine()

prediction=ThreatPrediction()

recommend=RecommendationEngine()



@brain_api.route("/brain")
def brain_view():

    return jsonify(brain.analyze())


@brain_api.route("/decision")
def decision_view():

    return jsonify(decision.decide())


@brain_api.route("/prediction")
def prediction_view():

    return jsonify(prediction.predict())


@brain_api.route("/recommendations")
def recommendation_view():

    return jsonify(recommend.suggest())


