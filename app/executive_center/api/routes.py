

from flask import Blueprint,jsonify,request


from app.executive_center.core.executive import ExecutiveSecurityCenter

from app.executive_center.core.report import ExecutiveReport



executive_api=Blueprint(

"executive",

__name__,

url_prefix="/api/executive"

)



center=ExecutiveSecurityCenter()

report=ExecutiveReport()




@executive_api.route("/dashboard")
def dashboard():


    return jsonify(

    center.dashboard()

    )





@executive_api.route("/report",methods=["POST"])
def create_report():


    return jsonify(

    report.generate(

    request.json or {}

    )

    )



