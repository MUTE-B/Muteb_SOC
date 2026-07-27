

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.integration.services import get_services

from app.search.engine import search



integration=Blueprint(

"integration",

__name__

)



@integration.route(

"/health",

methods=["GET"]

)

@jwt_required()

def health():


    return jsonify(

        get_services()

    )




@integration.route(

"/search",

methods=["POST"]

)

@jwt_required()

def global_search():


    data=request.json or {}


    return jsonify({

        "engine":

        "MUTEB Global Search",


        "results":

        search(

            data.get("query","")

        )

    })

