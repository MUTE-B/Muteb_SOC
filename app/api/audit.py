

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.audit.logger import get_audit



audit=Blueprint(

"audit",

__name__

)



@audit.route(

"/logs",

methods=["GET"]

)

@jwt_required()

def logs():


    return jsonify(

        get_audit()

    )

