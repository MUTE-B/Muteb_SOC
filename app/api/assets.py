

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.assets.database import (

add_asset,

get_assets

)


from app.vulnerability.manager import (

add_vulnerability,

get_vulnerabilities

)



assets=Blueprint(

"assets",

__name__

)



@assets.route(

"/",

methods=["GET"]

)

@jwt_required()

def list_assets():


    return jsonify(

        get_assets()

    )




@assets.route(

"/create",

methods=["POST"]

)

@jwt_required()

def create_asset():


    return jsonify(

        add_asset(

            request.json or {}

        )

    )




@assets.route(

"/vulnerabilities",

methods=["GET"]

)

@jwt_required()

def vulnerabilities():


    return jsonify(

        get_vulnerabilities()

    )




@assets.route(

"/vulnerability",

methods=["POST"]

)

@jwt_required()

def create_vulnerability():


    return jsonify(

        add_vulnerability(

            request.json or {}

        )

    )

