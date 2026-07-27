

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.hunting.query_engine import (

execute_query,

all_queries

)


from app.hunting.reports import hunting_report



hunting=Blueprint(

"hunting",

__name__

)



@hunting.route(

"/queries",

methods=["GET"]

)

@jwt_required()

def queries():


    return jsonify(

        all_queries()

    )




@hunting.route(

"/search",

methods=["POST"]

)

@jwt_required()

def search():


    data=request.json or {}


    return jsonify({

        "engine":

        "MUTEB Threat Hunting Engine",


        "results":

        execute_query(

            data.get("query","")

        )

    })




@hunting.route(

"/report",

methods=["POST"]

)

@jwt_required()

def report():


    return jsonify(

        hunting_report(

            request.json or {}

        )

    )

