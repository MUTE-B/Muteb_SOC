

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.notification.channels import (

send_notification,

history

)


from app.notification.escalation import create_escalation



notification=Blueprint(

"notification",

__name__

)



@notification.route(

"/send",

methods=["POST"]

)

@jwt_required()

def send():


    data=request.json or {}


    return jsonify(

        send_notification(

            data.get("channel","SYSTEM"),

            data.get("message","")

        )

    )




@notification.route(

"/escalate",

methods=["POST"]

)

@jwt_required()

def escalate():


    return jsonify(

        create_escalation(

            request.json or {}

        )

    )




@notification.route(

"/history",

methods=["GET"]

)

@jwt_required()

def logs():


    return jsonify(

        history()

    )

