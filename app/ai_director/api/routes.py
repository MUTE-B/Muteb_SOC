

from flask import Blueprint,jsonify,request


from app.ai_director.core.director import AISecurityDirector

from app.ai_director.reports.executive import ExecutiveAdvisor



ai_api=Blueprint(

"ai_director",

__name__,

url_prefix="/api/ai"

)



director=AISecurityDirector()

advisor=ExecutiveAdvisor()



@ai_api.route("/analyze",methods=["POST"])
def analyze():


    data=request.json or {}


    result=director.evaluate(data)


    return jsonify(result)




@ai_api.route("/executive",methods=["POST"])
def executive():


    data=request.json or {}


    result=director.evaluate(data)


    return jsonify(

    advisor.generate(result)

    )



