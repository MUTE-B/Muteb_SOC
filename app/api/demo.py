

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.demo.scenarios import get_demo_events

from app.demo.report import generate_report



demo=Blueprint(

"demo",

__name__

)



@demo.route(

"/events",

methods=["GET"]

)

@jwt_required()

def events():


    return jsonify(

        get_demo_events()

    )




@demo.route(

"/report",

methods=["GET"]

)

@jwt_required()

def report():


    return jsonify(

        generate_report(

            get_demo_events()

        )

    )

