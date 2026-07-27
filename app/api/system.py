

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.config.settings import get_settings

from app.health.monitor import health_status



system=Blueprint(

"system",

__name__

)



@system.route(

"/settings",

methods=["GET"]

)

@jwt_required()

def settings():


    return jsonify(

        get_settings()

    )




@system.route(

"/health",

methods=["GET"]

)

@jwt_required()

def health():


    return jsonify(

        health_status()

    )

