

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.repositories.alert_repository import alert_repository

from app.repositories.incident_repository import incident_repository



storage=Blueprint(

    "storage",

    __name__

)



@storage.route(

"/alert",

methods=["POST"]

)

@jwt_required()

def create_alert():


    return jsonify(

        alert_repository.create(

            request.json or {}

        )

    )




@storage.route(

"/incidents",

methods=["GET"]

)

@jwt_required()

def incidents():


    return jsonify(

        incident_repository.all()

    )

