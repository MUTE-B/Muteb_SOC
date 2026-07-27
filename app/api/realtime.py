

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.realtime.channel import (

publish,

stream

)


from app.realtime.monitor import system_status



realtime=Blueprint(

"realtime",

__name__

)



@realtime.route(

"/status",

methods=["GET"]

)

@jwt_required()

def status():


    return jsonify(

        system_status()

    )




@realtime.route(

"/publish",

methods=["POST"]

)

@jwt_required()

def create_event():


    return jsonify(

        publish(

            request.json or {}

        )

    )




@realtime.route(

"/stream",

methods=["GET"]

)

@jwt_required()

def events():


    return jsonify(

        stream()

    )

