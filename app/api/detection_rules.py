

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.detection.rules.database import (

get_rules,

add_rule,

update_rule

)


from app.detection.engine import detect



detection_rules=Blueprint(

"detection_rules",

__name__

)



@detection_rules.route(

"/rules",

methods=["GET"]

)

@jwt_required()

def rules():


    return jsonify(

        get_rules()

    )





@detection_rules.route(

"/rules",

methods=["POST"]

)

@jwt_required()

def create_rule():


    return jsonify(

        add_rule(

            request.json or {}

        )

    )





@detection_rules.route(

"/analyze",

methods=["POST"]

)

@jwt_required()

def analyze():


    return jsonify({

        "engine":

        "MUTEB Detection Rules Engine",


        "detections":

        detect(

            request.json or {}

        )

    })

