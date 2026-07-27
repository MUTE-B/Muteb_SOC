

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.ai.analyzer import (

summarize_alert,

recommend_actions

)


from app.ai.threat_explainer import explain



ai_security=Blueprint(

"ai_security",

__name__

)



@ai_security.route(

"/analyze",

methods=["POST"]

)

@jwt_required()

def analyze():


    data=request.json or {}


    return jsonify({


        "assistant":

        "MUTEB AI Security Assistant",


        "analysis":

        summarize_alert(data),


        "recommendations":

        recommend_actions(data)


    })




@ai_security.route(

"/explain",

methods=["POST"]

)

@jwt_required()

def explain_threat():


    data=request.json or {}


    return jsonify({


        "explanation":

        explain(

            data.get("threat")

        )

    })

