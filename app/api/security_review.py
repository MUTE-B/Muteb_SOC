

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from security.security_review import review



security_review=Blueprint(

"security_review",

__name__

)



@security_review.route(

"/review",

methods=["GET"]

)

@jwt_required()

def security():


    return jsonify(

        review()

    )

