

from flask import Blueprint,jsonify,request


from app.ai_copilot.assistant.core import AISecurityAssistant

from app.ai_copilot.analysis.analyzer import AIAlertAnalyzer

from app.ai_copilot.recommendation.engine import AIRecommendationEngine



ai_api=Blueprint(

"ai_copilot",

__name__,

url_prefix="/api/ai-copilot"

)



assistant=AISecurityAssistant()

analyzer=AIAlertAnalyzer()

recommend=AIRecommendationEngine()



@ai_api.route("/query")
def query():

    return jsonify(

    assistant.query(

    request.args.get(

    "question",

    "Security Status"

    )

    )

    )



@ai_api.route("/analysis")
def analysis():

    return jsonify(

    analyzer.analyze()

    )



@ai_api.route("/recommendations")
def recommendations():

    return jsonify(

    recommend.suggest()

    )



