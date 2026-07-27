

from flask import Blueprint,jsonify,request

from flask_jwt_extended import jwt_required


from app.reporting.engine import (

generate_security_report,

generate_executive_report

)


from app.reporting.exporter import export_json,export_html



reports=Blueprint(

"reports",

__name__

)



@reports.route(

"/security",

methods=["POST"]

)

@jwt_required()

def security_report():


    return jsonify(

        generate_security_report(

            request.json or {}

        )

    )




@reports.route(

"/executive",

methods=["POST"]

)

@jwt_required()

def executive_report():


    return jsonify(

        generate_executive_report(

            request.json or {}

        )

    )




@reports.route(

"/export",

methods=["POST"]

)

@jwt_required()

def export():


    data=request.json or {}


    report=data.get(

        "report",

        {}

    )


    return jsonify({


        "json":

        export_json(report),


        "html":

        export_html(report)

    })

