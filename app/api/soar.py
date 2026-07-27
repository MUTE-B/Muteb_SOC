

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.soar.playbooks.database import find_playbook

from app.soar.actions.engine import execute_actions



soar=Blueprint(

"soar",

__name__

)



@soar.route(

"/execute",

methods=["POST"]

)

@jwt_required()

def execute():


    data=request.json or {}


    trigger=data.get(

        "trigger"

    )


    playbook=find_playbook(

        trigger

    )


    if not playbook:


        return jsonify({

            "status":"NO_PLAYBOOK"

        })



    return jsonify({


        "engine":

        "MUTEB SOAR",


        "playbook":

        playbook["name"],


        "results":

        execute_actions(

            playbook["actions"],

            data

        )

    })





@soar.route(

"/playbooks",

methods=["GET"]

)

@jwt_required()

def playbooks():


    from app.soar.playbooks.database import get_playbooks


    return jsonify(

        get_playbooks()

    )

