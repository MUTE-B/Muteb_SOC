

from flask import Blueprint,jsonify,request


from app.intelligence.risk_ai.engine import AIRiskEngine

from app.intelligence.recommendation.engine import RecommendationEngine

from app.intelligence.executive_ai.summary import ExecutiveAI



ai_api=Blueprint(

"ai_intelligence",

__name__,

url_prefix="/api/ai"

)



risk_engine=AIRiskEngine()

recommend=RecommendationEngine()

executive=ExecutiveAI()



@ai_api.route("/risk",methods=["POST"])
def risk():

    data=request.json or {}


    result=risk_engine.calculate(data)


    return jsonify(result)





@ai_api.route("/recommendation",methods=["POST"])
def recommendation():


    data=request.json or {}


    return jsonify(

    recommend.generate(

    data.get(
    "score",
    0
    )

    )

    )





@ai_api.route("/executive",methods=["POST"])
def executive_summary():


    return jsonify(

    executive.generate(

    request.json or {}

    )

    )



