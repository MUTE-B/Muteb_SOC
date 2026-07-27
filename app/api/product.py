

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.product.info import get_product



product = Blueprint(

    "product",

    __name__

)



@product.route(

    "/info",

    methods=["GET"]

)

@jwt_required()

def info():


    return jsonify(

        get_product()

    )

