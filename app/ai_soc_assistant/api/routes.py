

from flask import Blueprint,jsonify


from app.ai_soc_assistant.analysis.engine import AISecurityAnalyst

from app.ai_soc_assistant.recommendation.engine import AIRecommendation

from app.ai_soc_assistant.incidents.summarizer import IncidentSummarizer



ai_soc_api=Blueprint(

"ai_soc_assistant",

__name__,

url_prefix="/api/ai-soc"

)



analyst=AISecurityAnalyst()

recommend=AIRecommendation()

summary=IncidentSummarizer()



@ai_soc_api.route("/analyze")
def analyze():

    return jsonify(

    analyst.analyze(

    "Suspicious Login Activity"

    )

    )



@ai_soc_api.route("/recommend")
def recommendation():

    return jsonify(

    recommend.suggest()

    )



@ai_soc_api.route("/summary")
def incident_summary():

    return jsonify(

    summary.create()

    )


