

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.release.version import release_info

from app.catalog.modules import modules



release=Blueprint(

"release",

__name__

)



@release.route(

"/info",

methods=["GET"]

)

@jwt_required()

def info():


    return jsonify(

        release_info()

    )




@release.route(

"/modules",

methods=["GET"]

)

@jwt_required()

def module_list():


    return jsonify(

        modules()

    )

