

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.showcase.profile import get_profile

from app.showcase.modules import modules



showcase=Blueprint(

"showcase",

__name__

)



@showcase.route(

"/profile",

methods=["GET"]

)

@jwt_required()

def profile():


    return jsonify(

        get_profile()

    )




@showcase.route(

"/modules",

methods=["GET"]

)

@jwt_required()

def showcase_modules():


    return jsonify({

        "modules":

        modules(),

        "count":

        len(modules())

    })

