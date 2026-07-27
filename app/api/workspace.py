

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.events.stream import (

add_event,

get_events

)


from app.workspace.notes import (

add_note,

get_notes

)



workspace=Blueprint(

"workspace",

__name__

)



@workspace.route(

"/events",

methods=["GET"]

)

@jwt_required()

def events():


    return jsonify(

        get_events()

    )




@workspace.route(

"/event",

methods=["POST"]

)

@jwt_required()

def create_event():


    return jsonify(

        add_event(

            request.json or {}

        )

    )




@workspace.route(

"/notes",

methods=["GET"]

)

@jwt_required()

def notes():


    return jsonify(

        get_notes()

    )




@workspace.route(

"/note",

methods=["POST"]

)

@jwt_required()

def create_note():


    return jsonify(

        add_note(

            request.json or {}

        )

    )

