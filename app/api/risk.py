

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.risk.scoring import (

calculate_risk,

classify

)


from app.automation.response import create_response



risk=Blueprint(

    "risk",

    __name__

)



@risk.route(

"/analyze",

methods=["POST"]

)

@jwt_required()

def analyze():


    data=request.json or {}


    severity=data.get(

        "severity",

        "LOW"

    )


    score=calculate_risk(

        severity

    )


    return jsonify({


        "severity":

        classify(score),


        "score":

        score,


        "response":

        create_response({

            "severity":severity,

            "score":score

        })


    })

