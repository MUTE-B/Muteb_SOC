

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.compliance.frameworks import get_frameworks

from app.compliance.report import compliance_report



compliance=Blueprint(

"compliance",

__name__

)



@compliance.route(

"/frameworks",

methods=["GET"]

)

@jwt_required()

def frameworks():


    return jsonify(

        get_frameworks()

    )




@compliance.route(

"/report",

methods=["GET"]

)

@jwt_required()

def report():


    return jsonify(

        compliance_report()

    )

