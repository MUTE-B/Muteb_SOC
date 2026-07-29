

from flask import Blueprint,jsonify


from app.ai_model_management.models.registry import AIModelRegistry

from app.ai_model_management.evaluation.engine import ModelEvaluation

from app.ai_model_management.prediction.engine import ThreatPrediction



ai_model_api=Blueprint(

"ai_model_management",

__name__,

url_prefix="/api/ai-models"

)



models=AIModelRegistry()

evaluation=ModelEvaluation()

prediction=ThreatPrediction()



@ai_model_api.route("/models")
def model_list():

    return jsonify(

    models.models()

    )



@ai_model_api.route("/evaluation")
def model_evaluation():

    return jsonify(

    evaluation.evaluate()

    )



@ai_model_api.route("/prediction")
def threat_prediction():

    return jsonify(

    prediction.predict()

    )



