

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.integrations.connectors import (

get_connectors,

connector_status

)


from app.integrations.gateway import (

receive_event,

history

)



integrations=Blueprint(

"integrations",

__name__

)



@integrations.route(

"/connectors",

methods=["GET"]

)

@jwt_required()

def connectors():


    return jsonify(

        get_connectors()

    )




@integrations.route(

"/connector",

methods=["POST"]

)

@jwt_required()

def connector():


    return jsonify(

        connector_status(

            (request.json or {}).get("name")

        )

    )




@integrations.route(

"/event",

methods=["POST"]

)

@jwt_required()

def external_event():


    return jsonify(

        receive_event(

            request.json or {}

        )

    )




@integrations.route(

"/history",

methods=["GET"]

)

@jwt_required()

def events():


    return jsonify(

        history()

    )

