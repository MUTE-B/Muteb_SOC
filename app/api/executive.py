

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.executive.kpi import calculate_kpis



executive=Blueprint(

"executive",

__name__

)



@executive.route(

"/dashboard",

methods=["GET"]

)

@jwt_required()

def dashboard():


    return jsonify(

        calculate_kpis()

    )

