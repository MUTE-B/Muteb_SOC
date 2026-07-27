

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.cases.database import (

create_case,

get_cases,

add_event

)


from app.investigation.evidence import (

add_evidence,

get_evidence

)



cases=Blueprint(

"cases",

__name__

)



@cases.route(

"/create",

methods=["POST"]

)

@jwt_required()

def create():


    return jsonify(

        create_case(

            request.json or {}

        )

    )




@cases.route(

"/",

methods=["GET"]

)

@jwt_required()

def all_cases():


    return jsonify(

        get_cases()

    )




@cases.route(

"/event",

methods=["POST"]

)

@jwt_required()

def event():


    data=request.json or {}


    return jsonify(

        add_event(

            data.get("case_id"),

            data.get("event")

        )

    )




@cases.route(

"/evidence",

methods=["POST"]

)

@jwt_required()

def evidence():


    return jsonify(

        add_evidence(

            request.json or {}

        )

    )




@cases.route(

"/evidence",

methods=["GET"]

)

@jwt_required()

def evidence_list():


    return jsonify(

        get_evidence()

    )

