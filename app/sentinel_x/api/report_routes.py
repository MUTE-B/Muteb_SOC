

from flask import Blueprint,jsonify


from app.sentinel_x.compliance.framework import ComplianceFramework



report_api=Blueprint(

"sentinel_reports",

__name__,

url_prefix="/api/sentinel"

)




@report_api.route("/reports/compliance")
def compliance():


    return jsonify(

    ComplianceFramework().map_controls()

    )




@report_api.route("/reports/status")
def reports_status():


    return jsonify({


    "platform":

    "MUTEB SOC Sentinel X",


    "reports":

    [

    "Analyst",

    "Management",

    "Executive"

    ],


    "status":

    "READY"



    })



