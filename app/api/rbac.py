

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.rbac.permissions import check_permission

from app.audit.logger import create_audit



rbac=Blueprint(

    "rbac",

    __name__

)



@rbac.route(

"/check",

methods=["POST"]

)

@jwt_required()

def check():


    data=request.json or {}


    result=check_permission(

        data.get("role"),

        data.get("permission")

    )


    create_audit(

        "admin",

        "PERMISSION_CHECK",

        data.get("permission")

    )


    return jsonify({

        "role":

        data.get("role"),


        "permission":

        data.get("permission"),


        "allowed":

        result

    })




@rbac.route(

"/roles",

methods=["GET"]

)

@jwt_required()

def roles():


    from app.rbac.permissions import ROLES


    return jsonify(ROLES)

